import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app.dart';
import 'data/api/api_client.dart';
import 'package:first_flutter_project/data/api/user.dart';

void main() async {
  //Retrofit
  final dio = Dio();
  final api = ApiClient(dio);
  //Retrofit

  //flutter_secure_storage
  final secureStorage = FlutterSecureStorage();
  //flutter_secure_storage

  //Hive
  //await Hive.initFlutter();
  //Hive

  runApp(App(apiClient: api, secureStorage: secureStorage));
}
