import 'package:first_flutter_project/ui/shared/taska_text_form_field.dart';
import 'package:first_flutter_project/ui/shared/taska_title_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

const myThemeColor = Color(0xFF665EE2);

class _DashboardScreenState extends State<DashboardScreen> {
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TableCalendar(
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: myThemeColor),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: myThemeColor),
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
                        style: TextStyle(
                          color: myThemeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        DateFormat('MMMM').format(date),
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
    final DateTime now = DateTime.now();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Мои задачи"),
        centerTitle: true,
        backgroundColor: Color(0xFFF8F7FD),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: TaskaTextFormField(labelText: "Что надо сделать?"),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: Row(
              children: [
                TaskaTitleText(
                  topText: "20 октября",
                  bottomText: "3 задачи на сегодня",
                ),
                Spacer(),
                IconButton(
                  onPressed: () => _showOverlay(context),
                  icon: Icon(Icons.calendar_month),
                  iconSize: 30,
                  style: IconButton.styleFrom(
                    side: BorderSide(color: Color(0xFFE7EFFD)),
                    shape: CircleBorder(),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 20),
            child: SizedBox(
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
                      border: Border.all(color: Color(0xFFE7EFFD)),
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0xFFF8F7FD),
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
          ),
        ],
      ),
    );
  }
}
