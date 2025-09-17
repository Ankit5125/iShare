import 'package:flutter/material.dart';
import 'package:ishare/Screens/SendScreen.dart';

class StartServerScreen extends StatefulWidget {
  final double buttonHeight;
  final String title;
  final Color borderColor;

  const StartServerScreen({
    required this.title,
    required this.borderColor,
    required this.buttonHeight,
    super.key,
  });

  @override
  State<StartServerScreen> createState() => _StartServerScreenState();
}

class _StartServerScreenState extends State<StartServerScreen> {
  @override
  void initState() {
    super.initState();
    // Wait 2 seconds then navigate
    Future.delayed(const Duration(milliseconds: 1800), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SendScreen(
            actionButtonHeight: widget.buttonHeight,
            title: "Send",
            borderColor: widget.borderColor,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Starting server...",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
