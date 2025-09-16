import 'package:first_flutter_project/data/api/user.dart';
import 'package:flutter/material.dart';
import 'app.dart';

import 'package:dio/dio.dart';
import 'data/api/api_client.dart';



void main() async {

  //Retrofit
  final dio = Dio();
  final api = ApiClient(dio);

  //Retrofit

  //Hive
  //await Hive.initFlutter();
  //Hive
  runApp(App(apiClient: api,));
  /*User user = User(name: "name", email: "email4@mail.ru", password: "password");*/
 /* try{
  final registeredUser = await api.registerUser(user);
  print(registeredUser.toJson());
  } on DioException catch (e) {
    if (e.response != null && e.response?.statusCode == 400){
      final errorJson = e.response!.data as Map<String, dynamic>;
      final error = ErrorResponse.fromJson(errorJson);
      print(error.detail);
    } else {
      print(e.message);
    }
  }*/
}
