import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:first_flutter_project/data/api/api_client.dart';
import 'package:first_flutter_project/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage;
  SplashScreen({required this.apiClient, required this.secureStorage});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final myThemeColor = Color(0xFF665EE2);
    return Scaffold(
      backgroundColor: myThemeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(flex: 1, child: Container(color: Colors.transparent)),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF8F7FD),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            height: screenHeight / 2,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Taska",
                  style: TextStyle(
                    fontFamily: 'Poller',
                    fontSize: 50,
                    color: myThemeColor,
                  ),
                ),
                Text(
                  "Персональный таск-трекер",
                  style: TextStyle(
                    fontSize: 45,
                    height: 1.1,
                    color: Color(0xFF2F394A),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Порядок в делах - порядок в уме",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB8B8BA),
                  ),
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(
                          apiClient: apiClient,
                          secureStorage: secureStorage,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: myThemeColor,
                    elevation: 20,
                    minimumSize: Size(320, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: myThemeColor,
                  ),
                  child: Text(
                    "Продолжить",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
