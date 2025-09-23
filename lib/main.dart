import 'package:flutter/material.dart';
import 'app.dart';
import 'injection/service_locator.dart';
import 'package:first_flutter_project/models/task.dart';


void main() async {
  //retrofit
  //flutter_secure_storage
  //get_it
  //hive
 setupLocator();

 Task testTask = Task(
   name: "Созвониться с заказчиком",
   date: DateTime(2025, 6, 10, 10, 0),
   priority: "Низкий",
   tag: "Работа",
 );

  //TODO Локализация календаря
  //await initializeDateFormatting('ru', '');

  runApp(App());
}
