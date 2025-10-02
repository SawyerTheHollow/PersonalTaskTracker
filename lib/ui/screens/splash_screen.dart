import 'package:first_flutter_project/ui/shared/taska_elevated_button.dart';
import 'package:first_flutter_project/ui/shared/taska_title_text.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_project/ui/screens/login_screen.dart';

import '../shared/palette.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff6d5bfd),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Container(
            decoration: BoxDecoration(),
            width: double.infinity,
            height: screenHeight / 2,
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              'assets/images/splashImage.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: taskaBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Taska",
                    style: TextStyle(
                      fontFamily: 'Poller',
                      fontSize: 50,
                      color: taskaPurplish,
                    ),
                  ),
                  TaskaTitleText(
                    topText: "Персональный таск-трекер",
                    bottomText: "Порядок в делах - порядок в уме",
                    topFontSize: 45,
                    bottomFontSize: 17,
                    topFontWeight: FontWeight.bold,
                    bottomFontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    height: 1.1,
                    spaceBetween: 10,
                    columnAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(height: 60),
                  TaskaElevatedButton(
                    text: "Продолжить",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    minimumSize: Size(320, 65),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
