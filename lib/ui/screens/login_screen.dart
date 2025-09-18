import 'package:first_flutter_project/ui/screens/dashboard_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'register_screen.dart';
import 'package:first_flutter_project/api/user.dart';
import 'package:first_flutter_project/api/api_client.dart';
import 'package:first_flutter_project/injection/service_locator.dart';

class LoginScreen extends StatefulWidget {
  final String? registeredEmail;
  final String? registeredPassword;

  LoginScreen({Key? key, this.registeredPassword, this.registeredEmail});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

const myThemeColor = Color(0xFF665EE2);
final _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailController.text = widget.registeredEmail ?? "";
    _passwordController.text = widget.registeredPassword ?? "";
    final apiClient = getIt<ApiClient>();
    final secureStorage = getIt<FlutterSecureStorage>();
    return Scaffold(
      backgroundColor: Color(0xFFF8F7FD),
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Вход"),
        centerTitle: true,
      ),
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
              style: TextStyle(fontSize: 15, color: Color(0xFFB8B8BA)),
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
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите свой Email";
                      }
                    },
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
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите свой пароль";
                      }
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          var userTockens = await apiClient.loginUser(
                            _emailController.text,
                            _passwordController.text,
                          );
                          await secureStorage.write(
                            key: "accessToken",
                            value: userTockens.accessToken,
                          );
                          await secureStorage.write(
                            key: "refreshToken",
                            value: userTockens.refreshToken,
                          );
                          userTockens = Tokens(
                            accessToken: "",
                            refreshToken: "",
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ),
                          );
                        } on DioException catch (e) {
                          if (e.response != Null &&
                              e.response!.statusCode == 401) {
                            final errorJson =
                                e.response!.data as Map<String, dynamic>;
                            final error = ErrorResponse.fromJson(errorJson);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.detail ?? "")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message ?? "")),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Заполните поля, выделенные красным'),
                          ),
                        );
                      }
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
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
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
