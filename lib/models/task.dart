import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Task extends HiveObject {

  final String name;
  final String? note;
  final String? tag;
  final DateTime date;
  final bool? deadline;
  final DateFormat? deadlineDate;
  final String priority;
  final bool completed;

  Task({
    required this.name,
    required this.date,
    required this.priority,
    this.note,
    this.tag,
    this.deadline,
    this.deadlineDate,
    this.completed = false
  });
}
