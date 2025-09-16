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
}
