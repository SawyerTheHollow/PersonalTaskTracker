import 'package:first_flutter_project/app.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:first_flutter_project/ui/shared/taska_elevated_button.dart';
import 'package:first_flutter_project/ui/shared/taska_task_list.dart';
import 'package:first_flutter_project/ui/shared/taska_task_sliver_list.dart';
import 'package:first_flutter_project/ui/shared/taska_toggle_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../injection/service_locator.dart';
import '../../models/task.dart';
import '../shared/taska_text_form_field.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({Key? key});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

String _selectedValue = "Все";

class _TasksScreenState extends State<TasksScreen> {
  final taskBox = getIt<Box>();
  //
  //tasks.clear();

  List<Task> _getAllTasks(String selectedValue) {
    List<Task> tasks = [];

    if (_selectedValue == "Все") {
      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        tasks.add(
          Task(
            title: taskData["name"],
            text: taskData["note"],
            tag: taskData["tag"],
            date: DateFormat('yyyy-MM-dd').parse(taskData['date']),
            //Не нужно на этом экране
            /*deadlineDate: DateFormat(
              'dd.MM.yyyy',
            ).parse(taskData['deadlineDate']),*/
            /*deadlineTime: TimeOfDay.fromDateTime(
              DateFormat('hh:mm').parse(taskData['deadlineTime']),
            ),*/
            priority: taskData["priority"],
          ),
        );
      }
    } else {
      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        if (taskData["tag"] == _selectedValue) {
          tasks.add(
            Task(
              title: taskData["name"],
              text: taskData["note"],
              tag: taskData["tag"],
              date: DateFormat('yyyy-MM-dd').parse(taskData['date']),
              //Не нужно на этом экране
              /*deadlineDate: DateFormat(
              'dd.MM.yyyy',
            ).parse(taskData['deadlineDate']),*/
              /*deadlineTime: TimeOfDay.fromDateTime(
              DateFormat('hh:mm').parse(taskData['deadlineTime']),
            ),*/
              priority: taskData["priority"],
            ),
          );
        }
      }
    }
    ;
    return tasks;
  }

  List<Task> _getCompletedTasks() {
    List<Task> tasks = [];


      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        if (taskData["isDone"] == true) {
        tasks.add(
          Task(
            title: taskData["name"],
            text: taskData["note"],
            tag: taskData["tag"],
            date: DateFormat('yyyy-MM-dd').parse(taskData['date']),
            //Не нужно на этом экране
            /*deadlineDate: DateFormat(
              'dd.MM.yyyy',
            ).parse(taskData['deadlineDate']),*/
            /*deadlineTime: TimeOfDay.fromDateTime(
              DateFormat('hh:mm').parse(taskData['deadlineTime']),
            ),*/
            priority: taskData["priority"],
          ),
        );
      }
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: taskaBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Мои задачи", style: TextStyle(color: taskaTextDark)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              ).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add_box_outlined, size: 35, color: taskaTextDark),
            padding: EdgeInsets.only(right: 20),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: TaskaHeaderDelegate(
                minHeight: 140,
                maxHeight: 140,
                child: Column(
                  children: [
                    TaskaTextFormField(
                      labelText: "Что надо сделать?",
                      height: 15,
                    ),
                    SizedBox(height: 20),
                    TaskaToggleButtons(
                      inactiveBorder: true,
                      minimumSize: Size(50, 35),
                      buttons: ["Все", "Покупки", "Работа", "Семья", "Учёба"],
                      selectedValue: _selectedValue,
                      onValueChanged: (String newValue) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            TaskaTaskSliverList(tasks: _getAllTasks(_selectedValue)),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    "Завершённые",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: taskaTextDark,
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios, color: taskaPurplish,)),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            TaskaTaskSliverList(tasks: _getCompletedTasks())
          ],
        ),
      ),

      /*CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: Text("data")),

              SliverToBoxAdapter(child: Text("data")),
            ],
          ),*/
    );

    /*return Scaffold(
      backgroundColor: taskaBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Мои задачи", style: TextStyle(color: taskaTextDark)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              ).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add_box_outlined, size: 35, color: taskaTextDark),
            padding: EdgeInsets.only(right: 20),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TaskaTextFormField(labelText: "Что надо сделать?", height: 15),
            SizedBox(height: 20),
            TaskaToggleButtons(
              inactiveBorder: true,
              minimumSize: Size(50, 35),
              buttons: ["Все", "Покупки", "Работа", "Семья", "Учёба"],
              selectedValue: _selectedValue,
              onValueChanged: (String newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
            ),

            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: Text("data")),
                TaskaTaskSliverList(tasks: _getAllTasks(_selectedValue)),
                SliverToBoxAdapter(child: Text("data")),
              ],
            ),

            /* Column(
                children: [
                  TaskaTaskList(tasks: _getAllTasks(_selectedValue)),
                ],
              ),*/
          ],
        ),
      ),
    );*/
  }
}
