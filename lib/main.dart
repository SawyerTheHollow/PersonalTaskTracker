import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app.dart';
import 'injection/service_locator.dart';

void main() async {
  //retrofit
  //flutter_secure_storage
  //get_it
  setupLocator();

  //TODO Локализация календаря
  //await initializeDateFormatting('ru', '');

  //Hive
  //await Hive.initFlutter();
  //Hive

  runApp(App());
}
