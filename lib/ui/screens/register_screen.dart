import 'package:first_flutter_project/ui/shared/taska_elevated_button.dart';
import 'package:first_flutter_project/ui/shared/taska_text_form_field.dart';
import 'package:first_flutter_project/ui/shared/taska_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:dio/dio.dart';
import 'package:first_flutter_project/api/api_client.dart';
import 'package:first_flutter_project/api/user.dart';
import 'package:first_flutter_project/ui/screens/login_screen.dart';
import 'package:first_flutter_project/injection/service_locator.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/palette.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late final RegExp emailRegex;

  @override
  void initState() {
    super.initState();
    emailRegex = RegExp(
      r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
  }

  @override
  Widget build(BuildContext context) {
    final apiClient = getIt<ApiClient>();
    return Scaffold(
      backgroundColor: taskaBackground,
      appBar: AppBar(
        backgroundColor: taskaBackground,
        toolbarHeight: 80,
        title: Text("Регистрация"),
        centerTitle: true,
        leadingWidth: 70,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: SvgPicture.asset("assets/icons/Back arrow.svg", width: 25, height: 25),
            padding: EdgeInsets.all(10),
            style: IconButton.styleFrom(
              side: BorderSide(color: taskaBorder),
              shape: CircleBorder(),
              backgroundColor: Colors.transparent,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TaskaTitleText(
              topText: "Создать аккаунт",
              bottomText: "Заполните поля для регистрации",
            ),
            SizedBox(height: 60),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TaskaTextFormField(
                    labelText: "Введите ваше имя",
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите ваше имя";
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  TaskaTextFormField(
                    labelText: "Введите Email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите свой Email";
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return "Некорректный формат email";
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  TaskaTextFormField(
                    labelText: "Введите пароль",
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите свой пароль";
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  TaskaElevatedButton(
                    text: "Регистрация",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User userToRegister = User(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        try {
                          final registeredUser = await apiClient.registerUser(
                            userToRegister,
                          );
                          print(registeredUser.toJson());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                registeredEmail: _emailController.text,
                                registeredPassword: _passwordController.text,
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Вы успешно зарегестрировались, используйте ваши данные для входа',
                              ),
                            ),
                          );
                        } on DioException catch (e) {
                          if (e.response != null &&
                              e.response?.statusCode == 400) {
                            final errorJson =
                                e.response!.data as Map<String, dynamic>;
                            final error = ErrorResponse.fromJson(errorJson);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.detail ?? "Null")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message ?? "Null")),
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
                  SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Есть аккаунт? ",
                          style: TextStyle(
                            color: taskaTextGray,
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: "Войти",
                          style: TextStyle(
                            color: taskaPurplish,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
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
