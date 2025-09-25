import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Task extends HiveObject {

  final String title;
  final String? text;
  final String? tag;
  final DateTime date;
  //final TimeOfDay? time;
  final DateTime? deadlineDate;
  final TimeOfDay? deadlineTime;
  final String priority;
  final bool completed;

  Task({
    required this.title,
    required this.date,
    required this.priority,
    //this.time,
    this.text,
    this.tag,
    this.deadlineDate,
    this.deadlineTime,
    this.completed = false
  });
}
