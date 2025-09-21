import 'package:first_flutter_project/ui/screens/dashboard_screen.dart';
import 'package:first_flutter_project/ui/shared/taska_elevated_button.dart';
import 'package:first_flutter_project/ui/shared/taska_text_form_field.dart';
import 'package:first_flutter_project/ui/shared/taska_title_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../shared/palette.dart';
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
      backgroundColor: taskaBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
            TaskaTitleText(
              topText: "Добро пожаловать",
              bottomText: "Введите E-mail и пароль для входа",
            ),
            SizedBox(height: 60),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TaskaTextFormField(
                    labelText: "Введите Email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите свой Email";
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  TaskaTextFormField(
                    obscureText: true,
                    labelText: "Введите пароль",
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите свой пароль";
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  TaskaElevatedButton(
                    text: "Вход",
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
                  ),
                  SizedBox(height: 40),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Нет аккаунта? ",
                          style: TextStyle(
                            color: taskaTextGray,
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: "Зарегистрироваться",
                          style: TextStyle(
                            color: taskaPurplish,
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
            TaskaElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
              text: "Пропустить (Debug)",
            ),
          ],
        ),
      ),
    );
  }
}
