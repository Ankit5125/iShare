import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ishare/Server/Server.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class SendScreen extends StatefulWidget {
  String title;
  double actionButtonHeight;
  Color borderColor;

  SendScreen({
    required this.borderColor,
    required this.title,
    required this.actionButtonHeight,
    super.key,
  });

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  @override
  void initState() {
    startServer();
    super.initState();
  }

  @override
  void dispose() {
    emptyList();
    endServer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Container(
            height: widget.actionButtonHeight,
            width: widget.actionButtonHeight,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(image: AssetImage("assets/gifs/send.gif")),
              boxShadow: [
                BoxShadow(
                  color: widget.borderColor,
                  blurRadius: 100,
                  spreadRadius: 100,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getIp(),
              builder: (context, snapshot) {
                ConnectionState state = snapshot.connectionState;
                if (state == ConnectionState.waiting ||
                    state == ConnectionState.active) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Go to : ${snapshot.data!}",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Or"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Scan : "),
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child: QrImageView(
                              data: snapshot.data!,
                              size: 150,
                              eyeStyle: QrEyeStyle(color: Colors.black),
                              dataModuleStyle: QrDataModuleStyle(
                                color: Colors.black,
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                190,
                                216,
                                255,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickFiles, // Call the file picker on button click
              child: Text('Select Files'),
            ),
            SizedBox(height: 20),
            Text('Selected Files:'),
            ...selectedFiles.map(
              (file) => Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    "\n\t${file.path.split('/').last}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ), // List selected files
          ],
        ),
      ),
    );
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      // Add the selected files to the list
      setState(() {
        selectedFiles = result.paths.map((path) => File(path!)).toList();
      });
    } else {
      // User canceled file selection
      print("No files selected");
    }
  }
}
