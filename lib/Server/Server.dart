import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

List<File> selectedFiles = [];

var handler = const Pipeline()
    .addMiddleware(logRequests()) // Optional: log requests
    .addHandler(_requestHandler);

late dynamic server;

void emptyList() {
  selectedFiles = [];
}

Future<String> getIp() async {
  var ip = await _getLocalIpAddress();
  return "http://$ip:8080";
}

void startServer() async {
  // Get the device's local IP address
  var ip = await _getLocalIpAddress();

  // Start the server on port 8080
  server = await shelf_io.serve(handler, ip, 8080);

  print('Server running at http://$ip:8080 ✅');
}

void endServer() async {
  server = await server.close();
  print("Server Closed Succesfully ✅");
}

Future<String> _getLocalIpAddress() async {
  var interfaces = await NetworkInterface.list();
  for (var interface in interfaces) {
    if (interface.addresses.isNotEmpty && interface.name != 'lo0') {
      return interface.addresses.first.address;
    }
  }
  return 'localhost';
}

// Request handler to serve files (images, videos, or other files)
Response _requestHandler(Request request) {
  final path = Uri.decodeComponent(request.url.path);
  // Path is already a String

  if (path == '' || path == '/') {
    return Response.ok(
      _generateHtml(),
      headers: {'Content-Type': 'text/html'},
    ); // Show the homepage
  }

  // Check if the requested path corresponds to a file in the selected files
  for (var file in selectedFiles) {
    if (file.uri.pathSegments.last == path) {
      try {
        return Response.ok(
          file.readAsBytesSync(),
          headers: {
            'Content-Type': _getContentType(
              file.path,
            ), // Set proper content type for images, videos, etc.
          },
        );
      } catch (e) {
        return Response.notFound('File not found');
      }
    }
  }

  return Response.notFound('File not found');
}

// Generate an HTML page showing the files available for download or viewing
String _generateHtml() {
  String filesList = selectedFiles
      .map((file) {
        final fileName = file.uri.pathSegments.last;
        final filePath = '/$fileName';

        String fileBadge = '';
        String preview = '';

        if (fileName.endsWith('.mp4') ||
            fileName.endsWith('.avi') ||
            fileName.endsWith('.mov')) {
          fileBadge = '<span class="badge bg-secondary">Video</span>';
          preview =
              '''
        <video class="card-img-top" controls>
          <source src="$filePath" type="${_getContentType(file.path)}">
        </video>
      ''';
        } else if (fileName.endsWith('.pdf')) {
          fileBadge = '<span class="badge bg-danger">PDF</span>';
          preview =
              '<iframe src="$filePath" height="220" style="border:none; width:100%; border-top-left-radius:12px; border-top-right-radius:12px;"></iframe>';
        } else if (fileName.endsWith('.jpg') ||
            fileName.endsWith('.jpeg') ||
            fileName.endsWith('.png') ||
            fileName.endsWith('.gif')) {
          fileBadge = '<span class="badge bg-info text-dark">Image</span>';
          preview =
              '<img src="$filePath" class="card-img-top" alt="$fileName">';
        } else {
          fileBadge = '<span class="badge bg-dark">File</span>';
        }

        return '''
      <div class="col-md-4 mb-4">
        <div class="card border-0 shadow-sm h-100">
          $preview
          <div class="card-body d-flex flex-column">
            <h6 class="card-title mb-2 fw-semibold">$fileName</h6>
            <div class="mb-3">$fileBadge</div>
            <a href="$filePath" download class="btn btn-outline-primary mt-auto">Download</a>
          </div>
        </div>
      </div>
    ''';
      })
      .join('');

  return '''
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>File Server</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <style>
          body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            color: #212529;
          }
          .navbar {
            background-color: #ffffff;
            border-bottom: 1px solid #e5e7eb;
          }
          .navbar-brand {
            font-weight: 600;
            font-size: 1.2rem;
            color: #0d6efd !important;
          }
          .card {
            border-radius: 12px;
          }
          .card-img-top {
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            object-fit: cover;
          }
          .btn {
            border-radius: 8px;
          }
          h1 {
            font-weight: 600;
            color: #111827;
          }
        </style>
      </head>
      <body>
        <nav class="navbar navbar-light sticky-top">
          <div class="container-fluid">
            <a class="navbar-brand" href="#">File Server</a>
          </div>
        </nav>

        <div class="container mt-5">
          <h1 class="mb-4 text-center">Files Available</h1>
          <div class="row">
            $filesList
          </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
      </body>
    </html>
  ''';
}

String _getContentType(String path) {
  if (path.endsWith('.jpg') ||
      path.endsWith('.jpeg') ||
      path.endsWith('.webp')) {
    return 'image/jpeg';
  } else if (path.endsWith('.png')) {
    return 'image/png';
  } else if (path.endsWith('.gif')) {
    return 'image/gif';
  } else if (path.endsWith('.bmp')) {
    return 'image/bmp';
  } else if (path.endsWith('.mp4')) {
    return 'video/mp4'; // Video files (mp4)
  } else if (path.endsWith('.avi')) {
    return 'video/x-msvideo'; // AVI video files
  } else if (path.endsWith('.mov')) {
    return 'video/quicktime'; // MOV video files
  } else if (path.endsWith('.pdf')) {
    return 'application/pdf'; // PDF files
  } else if (path.endsWith('.txt')) {
    return 'text/plain'; // Text files
  } else if (path.endsWith('.docx')) {
    return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'; // DOCX files
  } else {
    return 'application/octet-stream'; // Default for unknown files
  }
}

void startServervi() async {
  // Create a simple handler that serves a basic HTML page
  var router = Router()
    ..get('/', (Request request) {
      return Response.ok(
        '<h1>Welcome to my server!</h1>',
        headers: {'Content-Type': 'text/html'},
      );
    });

  // Create a handler pipeline, optional logging
  var handler = const Pipeline()
      .addMiddleware(logRequests()) // Optional: log requests
      .addHandler(router);

  // Use your local IP (replace with your actual local IP)
  var ip =
      '0.0.0.0'; // Listens on all interfaces (or you can use a specific local IP like '192.168.x.x')
  var server = await shelf_io.serve(handler, ip, 3000);

  print('Server running at http://$ip:3000');
}
