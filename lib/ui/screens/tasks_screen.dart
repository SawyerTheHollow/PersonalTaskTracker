import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:first_flutter_project/ui/shared/taska_task_sliver_list.dart';
import 'package:first_flutter_project/ui/shared/taska_toggle_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../injection/service_locator.dart';
import '../../models/task.dart';
import '../shared/taska_text_form_field.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  final VoidCallback? onUpdate;
  TasksScreen({Key? key, this.onUpdate});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final taskBox = getIt<Box>();

  TextEditingController _searchBarController = TextEditingController();

  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = "Все";
  }

  List<Task> _getAllTasks(String selectedValue) {
    List<Task> tasks = [];
    if (_searchBarController.text != "") {
      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        String title = taskData["title"];
        String text = taskData["text"];
        if (title.toLowerCase().contains(
              _searchBarController.text.toLowerCase(),
            ) ||
            text.toLowerCase().contains(
              _searchBarController.text.toLowerCase(),
            ))
          if (taskData['isDone'] == false) {
            tasks.add(
              Task(
                title: taskData["title"],
                text: taskData["text"],
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
                hiveIndex: key,
              ),
            );
          }
      }
    } else if (_selectedValue == "Все") {
      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        if (taskData['isDone'] == false) {
          tasks.add(
            Task(
              title: taskData["title"],
              text: taskData["text"],
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
              hiveIndex: key,
            ),
          );
        }
      }
    } else {
      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        if (taskData["tag"] == _selectedValue) {
          if (taskData['isDone'] == false) {
            tasks.add(
              Task(
                title: taskData["title"],
                text: taskData["text"],
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
                hiveIndex: key,
              ),
            );
          }
        }
      }
    }
    ;

    return tasks;
  }

  List<Task> _getCompletedTasks() {
    List<Task> tasks = [];

    if (_selectedValue == "Все") {
      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        if (taskData["isDone"] == true) {
          tasks.add(
            Task(
              title: taskData["title"],
              text: taskData["text"],
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
              hiveIndex: key,
            ),
          );
        }
      }
    } else {
      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        if (taskData["isDone"] == true) {
          if (taskData["tag"] == _selectedValue) {
            tasks.add(
              Task(
                title: taskData["title"],
                text: taskData["text"],
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
                hiveIndex: key,
              ),
            );
          }
        }
      }
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: taskaBackground,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Задачи", style: TextStyle(color: taskaTextDark)),
        centerTitle: true,
        backgroundColor: taskaBackground,
        leadingWidth: 70,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Back arrow.svg",
              width: 25,
              height: 25,
            ),
            padding: EdgeInsets.all(10),
            style: IconButton.styleFrom(
              side: BorderSide(color: taskaBorder),
              shape: CircleBorder(),
              backgroundColor: Colors.transparent,
            ),
            onPressed: () async {
              widget.onUpdate?.call();
              Navigator.pop(context);
            },
          ),
        ),

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
            icon: SvgPicture.asset(
              "assets/icons/Plus.svg",
              width: 30,
              height: 30,
            ),

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
                minHeight: 150,
                maxHeight: 150,
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    TaskaTextFormField(
                      labelText: "Что надо сделать?",
                      controller: _searchBarController,
                      height: 15,
                      prefixIcon: SvgPicture.asset(
                        "assets/icons/Search.svg",
                        width: 25,
                        height: 25,
                      ),
                      onChanged: (string) {
                        setState(() {
                          _selectedValue = "Все";
                        });
                      },
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
            TaskaTaskSliverList(
              tasks: _getAllTasks(_selectedValue),
              onUpdate: () {
                setState(() {});
              },
            ),
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
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, color: taskaPurplish),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            TaskaTaskSliverList(tasks: _getCompletedTasks()),
          ],
        ),
      ),
    );
  }
}
