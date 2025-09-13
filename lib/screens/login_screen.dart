import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _value;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final myThemeColor = Color(0xFF665EE2);
    return Scaffold(
      backgroundColor: Color(0xFFF8F7FD),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Добро пожаловать",
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFF2F394A),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Введите E-mail и пароль для входа",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFFB8B8BA),
              ),
            ),
            SizedBox(height: 60),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Введите Email",
                      labelStyle: TextStyle(color: Color(0xFF838993)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Color(0xFFE7EFFD)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: myThemeColor),
                      ),
                    ),

                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Введите пароль",
                      labelStyle: TextStyle(color: Color(0xFF838993)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Color(0xFFE7EFFD)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: myThemeColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      /*TODO Выполнние входа*/
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: myThemeColor,
                      elevation: 20,
                      minimumSize: Size(0, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      backgroundColor: myThemeColor,
                    ),
                    child: Text(
                      "Вход",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Нет аккаунта? ",
                          style: TextStyle(
                            color: Color(0xFFB8B8BA),
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: "Зарегистрироваться",
                          style: TextStyle(
                            color: myThemeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              /*TODO Переход к регистрации*/
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
