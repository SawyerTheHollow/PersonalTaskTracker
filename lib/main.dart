import 'package:flutter/material.dart';
import 'app.dart';
import 'injection/service_locator.dart';

void main() async {
  //retrofit
  //flutter_secure_storage
  //get_it
  setupLocator();

  //Hive
  //await Hive.initFlutter();
  //Hive

  runApp(App());
}
