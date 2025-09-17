import 'package:flutter/material.dart';
import 'package:ishare/Screens/SendScreen.dart';
import 'package:ishare/Screens/StartServerScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  double buttonHeight = 75;
  final boxBordercolor = Color.fromARGB(255, 119, 186, 241);

  @override
  Widget build(BuildContext context) {
    buttonHeight = MediaQuery.of(context).size.width * 0.4;
    final textSize = MediaQuery.of(context).size.width * 0.05;
    final stepFontSize = textSize * 0.7;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // fontFamily: "BitCountSingle",
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          Text(
            "Follow These Steps first: ",
            style: TextStyle(
              fontSize: textSize * 0.8,
              color: const Color.fromARGB(255, 74, 116, 151),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Enable Hotspot in Sender Device",
                style: TextStyle(
                  fontSize: stepFontSize,
                  color: const Color.fromARGB(255, 74, 116, 151),
                ),
              ),
              Text(
                "2. Connect Receiver Device to Network",
                style: TextStyle(
                  fontSize: stepFontSize,
                  color: const Color.fromARGB(255, 74, 116, 151),
                ),
              ),
              Text(
                "3. Go To url or SCAN QR",
                style: TextStyle(
                  fontSize: stepFontSize,
                  color: const Color.fromARGB(255, 74, 116, 151),
                ),
              ),
              // Text(
              //   "3. Enable location",
              //   style: TextStyle(
              //     fontSize: stepFontSize,
              //     color: const Color.fromARGB(255, 74, 116, 151),
              //   ),
              // ),
            ],
          ),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StartServerScreen(
                            title: 'Send',
                            borderColor: boxBordercolor,
                            buttonHeight: buttonHeight,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: buttonHeight,
                      width: buttonHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: boxBordercolor),
                        image: DecorationImage(
                          image: AssetImage("assets/gifs/send.gif"),
                        ),
                      ),
                    ),
                  ),
                  Text("Send", style: TextStyle(fontSize: textSize)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
