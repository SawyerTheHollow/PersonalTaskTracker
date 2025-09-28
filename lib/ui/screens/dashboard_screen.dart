import 'package:first_flutter_project/injection/service_locator.dart';
import 'package:first_flutter_project/models/task.dart';
import 'package:first_flutter_project/ui/screens/add_task_screen.dart';
import 'package:first_flutter_project/ui/screens/tasks_screen.dart';
import 'package:first_flutter_project/ui/shared/taska_task_list.dart';
import 'package:first_flutter_project/ui/shared/taska_text_form_field.dart';
import 'package:first_flutter_project/ui/shared/taska_title_text.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final taskBox = getIt<Box>();

  //Задачи
  DateTime _selectedDay = DateTime.now();
  List<Task> _getTasksForDay(DateTime day) {
    final List<Task> tasks = [];
    final formattedDay = DateFormat('yyyy-MM-dd').format(day).toString();

    for (final key in taskBox.keys) {
      final taskData = taskBox.get(key);
      final preFormattedDate = DateFormat('yyyy-MM-dd').parse(taskData["date"]);
      final formattedDate = DateFormat(
        'yyyy-MM-dd',
      ).format(preFormattedDate).toString();
      if (formattedDate == formattedDay) {
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
    ;

    return tasks;
  }

  //Календарь
  final GlobalKey _scaffoldKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(_scaffoldKey.currentContext!);
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () => _hideOverlay(_overlayEntry!),
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Center(
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: 300,
                height: 340,
                decoration: BoxDecoration(
                  color: taskaBackground,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TableCalendar(
                  eventLoader: _getTasksForDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });
                    _hideOverlay(_overlayEntry!);
                  },
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: taskaPurplish),
                    todayDecoration: BoxDecoration(
                      color: taskaBackground,
                      shape: BoxShape.circle,
                      border: Border.all(color: taskaPurplish),
                    ),
                  ),
                  firstDay: DateTime(2010, 1, 1),
                  lastDay: DateTime(2030, 1, 1),
                  focusedDay: DateTime.now(),
                  rowHeight: 40,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(Icons.arrow_back),
                    rightChevronIcon: Icon(Icons.arrow_forward),
                  ),
                  calendarBuilders: CalendarBuilders(
                    headerTitleBuilder: (context, date) {
                      return Text(
                        DateFormat('MMMM').format(date),
                        style: TextStyle(
                          color: taskaPurplish,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  void _hideOverlay(OverlayEntry entry) {
    entry.remove();
  }

  //Основная вёрстка
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: taskaBackground,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TasksScreen()),
            );
          },
          icon: Icon(Icons.arrow_forward_ios),
        ),
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text(
          "Мои задачи",
          style: TextStyle(color: taskaTextDark),
        ),
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
      body:
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: TaskaTextFormField(
                  labelText: "Что надо сделать?",
                  height: 15,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    TaskaTitleText(
                      topText: DateFormat('dd MMMM').format(_selectedDay),
                      bottomText:
                          "${_getTasksForDay(_selectedDay).length} задачи на сегодня",
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => _showOverlay(context),
                      icon: Icon(Icons.calendar_month, color: taskaTextDark),
                      iconSize: 30,
                      style: IconButton.styleFrom(
                        side: BorderSide(color: taskaBorder),
                        shape: CircleBorder(),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          DateTime date = DateTime.now().add(
                            Duration(days: index),
                          );
                          return Container(
                            width: 60,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: taskaBorder),
                              borderRadius: BorderRadius.circular(18),
                              color: taskaBackground,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.E().format(date),
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  DateFormat.d().format(date),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: TaskaTaskList(tasks: _getTasksForDay(_selectedDay)),
              ),
            ],
          ),

    );
  }
}
