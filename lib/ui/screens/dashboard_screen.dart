import 'package:first_flutter_project/injection/service_locator.dart';
import 'package:first_flutter_project/models/task.dart';
import 'package:first_flutter_project/ui/screens/add_task_screen.dart';
import 'package:first_flutter_project/ui/screens/tasks_screen.dart';
import 'package:first_flutter_project/ui/shared/taska_horizontal_calendar.dart';
import 'package:first_flutter_project/ui/shared/taska_task_list.dart';
import 'package:first_flutter_project/ui/shared/taska_text_form_field.dart';
import 'package:first_flutter_project/ui/shared/taska_title_text.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  final _searchBarController = TextEditingController();

  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late String _monthTitle;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _monthTitle =
        DateFormat.MMMM('ru').format(_focusedDay)[0].toUpperCase() +
        DateFormat.MMMM('ru').format(_focusedDay).substring(1);
  }

  //Задачи
  List<Task> _getTasksForDay(DateTime day) {
    final List<Task> tasks = [];
    final List<Task> completedTasks = [];
    final formattedDay = DateFormat('yyyy-MM-dd').format(day).toString();

    if (_searchBarController.text != "") {
      for (final key in taskBox.keys) {
        final taskData = taskBox.get(key);
        String title = taskData["title"];
        String text = taskData["text"];
        final preFormattedDate = DateFormat(
          'yyyy-MM-dd',
        ).parse(taskData["date"]);
        final formattedDate = DateFormat(
          'yyyy-MM-dd',
        ).format(preFormattedDate).toString();

        if (formattedDate == formattedDay &&
            (title.toLowerCase().contains(
                  _searchBarController.text.toLowerCase(),
                ) ||
                text.toLowerCase().contains(
                  _searchBarController.text.toLowerCase(),
                )))
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
          } else {
            completedTasks.add(
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
        final preFormattedDate = DateFormat(
          'yyyy-MM-dd',
        ).parse(taskData["date"]);
        final formattedDate = DateFormat(
          'yyyy-MM-dd',
        ).format(preFormattedDate).toString();

        if (formattedDate == formattedDay) {
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
          } else {
            completedTasks.add(
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
      ;
    }
    return tasks + completedTasks;
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
                  onPageChanged: (date) {
                    _focusedDay = date;
                    _monthTitle =
                        DateFormat.MMMM(
                          'ru',
                        ).format(_focusedDay)[0].toUpperCase() +
                        DateFormat.MMMM('ru').format(_focusedDay).substring(1);
                  },
                  locale: 'ru_RU',
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
                  focusedDay: _focusedDay,
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
                        _monthTitle,
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

  //Функция обновления значения _selectedDay (для TaskaHorizontalCalendar)
  void _updateSelectedDay(DateTime newDay) {
    setState(() {
      _selectedDay = newDay;
    });
  }

  //Основная вёрстка
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: taskaBackground,
      key: _scaffoldKey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Мои задачи", style: TextStyle(color: taskaTextDark)),
        centerTitle: true,
        backgroundColor: taskaBackground,
        leadingWidth: 70,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Forward arrow.svg",
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
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TasksScreen()),
              );
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TaskaTextFormField(
              controller: _searchBarController,
              labelText: "Что надо сделать?",
              height: 15,
              prefixIcon: SvgPicture.asset(
                "assets/icons/Search.svg",
                width: 25,
                height: 25,
              ),
              onChanged: (string) {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                TaskaTitleText(
                  topText: DateFormat.MMMMd('ru').format(_selectedDay),
                  bottomText:
                      _getTasksForDay(
                        _selectedDay,
                      ).length.toString().endsWith('1')
                      ? "${_getTasksForDay(_selectedDay).length} задача на сегодня"
                      : _getTasksForDay(
                          _selectedDay,
                        ).length.toString().endsWith('2')
                      ? "${_getTasksForDay(_selectedDay).length} задачи на сегодня"
                      : _getTasksForDay(
                          _selectedDay,
                        ).length.toString().endsWith('3')
                      ? "${_getTasksForDay(_selectedDay).length} задачи на сегодня"
                      : _getTasksForDay(
                          _selectedDay,
                        ).length.toString().endsWith('4')
                      ? "${_getTasksForDay(_selectedDay).length} задачи на сегодня"
                      : _getTasksForDay(
                          _selectedDay,
                        ).length.toString().endsWith('11')
                      ? "${_getTasksForDay(_selectedDay).length} задач на сегодня"
                      : _getTasksForDay(
                          _selectedDay,
                        ).length.toString().endsWith('12')
                      ? "${_getTasksForDay(_selectedDay).length} задач на сегодня"
                      : _getTasksForDay(
                          _selectedDay,
                        ).length.toString().endsWith('13')
                      ? "${_getTasksForDay(_selectedDay).length} задач на сегодня"
                      : _getTasksForDay(
                          _selectedDay,
                        ).length.toString().endsWith('14')
                      ? "${_getTasksForDay(_selectedDay).length} задач на сегодня"
                      : "${_getTasksForDay(_selectedDay).length} задач на сегодня",
                ),
                Spacer(),
                IconButton(
                  onPressed: () => _showOverlay(context),
                  icon: SvgPicture.asset(
                    "assets/icons/Calendar.svg",
                    width: 25,
                    height: 25,
                  ),
                  padding: EdgeInsets.all(10),
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
            child: TaskaHorizontalCalendar(
              selectedDay: _selectedDay,
              onUpdate: _updateSelectedDay,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: TaskaTaskList(
                tasks: _getTasksForDay(_selectedDay),
                onUpdate: () {
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
