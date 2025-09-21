import 'package:first_flutter_project/models/task.dart';
import 'package:first_flutter_project/ui/shared/taska_text_form_field.dart';
import 'package:first_flutter_project/ui/shared/taska_title_text.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //Задачи
  DateTime _selectedDay = DateTime.now();

  final Map<DateTime, List<Task>> _tasks = {
    DateTime(2025, 9, 21): [
      Task(
        name: "Созвониться с заказчиком",
        date: DateTime(2025, 6, 10, 10, 0),
        priority: "Низкий",
        tag: "Работа",
      ),
      Task(
        name: "Заказать бабушке подарок",
        date: DateTime(2025, 6, 10, 14, 0),
        priority: "Средний",
        tag: "Семья",
      ),
      Task(
        name: "Подготовить доклад",
        date: DateTime(2025, 6, 10, 14, 0),
        priority: "Средний",
        tag: "Учёба",
      ),
      Task(
        name: "Сдать отчёт",
        date: DateTime(2025, 6, 10, 14, 0),
        priority: "Средний",
        tag: "Учёба",
      ),
      Task(
        name: "Что-то",
        date: DateTime(2025, 6, 10, 14, 0),
        priority: "Средний",
      ),
      Task(
        name: "Что-то",
        date: DateTime(2025, 6, 10, 14, 0),
        priority: "Средний",
      ),
    ],
  };

  List<Task> _getTasksForDay(DateTime day) {
    return _tasks[DateTime(day.year, day.month, day.day)] ?? [];
  }



  Widget _buildTaskList() {
    final tasks = _getTasksForDay(_selectedDay);

    if (tasks.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Нет событий на этот день',
            style: TextStyle(color: taskaTextGray),
          ),
        ),
      );
    }

    return SizedBox(
      height: 450,
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: taskaBorder),
            ),
            color: taskaBackground,
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Container(
              height: 80,
              child: ListTile(
                //TODO Добавить чек-марки
                leading: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ), //Чек-марки
                title: Text(task.name, style: TextStyle(color: taskaTextDark, fontSize: 17),),
                subtitle: RichText(text: TextSpan(children: [WidgetSpan(alignment: PlaceholderAlignment.middle, child: Icon(Icons.local_offer_outlined, size: 15, color: taskaPurplish,)),TextSpan(text: " "), TextSpan(text: task.tag, style: TextStyle(fontSize: 15, color: taskaTextGray))])),
                onTap: () {
                  //TODO Выделение чек-марка
                  print('Событие: ${task.name}');
                },
                trailing: Icon(Icons.info_outline, color: Color(0xffafd77e),),
              ),
            ),
          );
        },
      ),
    );
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
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Мои задачи", style: TextStyle(color: taskaTextDark),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined, size: 35,color: taskaTextDark,), padding: EdgeInsets.only(right: 20),),],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TaskaTextFormField(labelText: "Что надо сделать?"),
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
                  icon: Icon(Icons.calendar_month, color: taskaTextDark,),
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
                      DateTime date = DateTime.now().add(Duration(days: index));
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
            child: _buildTaskList(),
          ),
        ],
      ),
    );
  }
}
