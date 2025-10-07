import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Task extends HiveObject {

  final String title;
  final String? text;
  final String? tag;
  final DateTime date;
  //final TimeOfDay? time;
  final DateTime? finishAt;
  //final TimeOfDay? deadlineTime;
  final String priority;
  bool isDone;
  final dynamic hiveIndex;

  Task({
    required this.title,
    required this.date,
    required this.priority,
    //this.time,
    this.text,
    this.tag,
    this.finishAt,
    //this.deadlineTime,
    this.isDone = false,
    required this.hiveIndex
  });
}
