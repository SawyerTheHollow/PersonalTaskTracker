import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskaHorizontalCalendar extends StatefulWidget {
  DateTime selectedDay;
  final Function(DateTime)? onUpdate;

  TaskaHorizontalCalendar({required this.selectedDay, this.onUpdate});

  @override
  _TaskaHorizontalCalendar createState() => _TaskaHorizontalCalendar();
}

class _TaskaHorizontalCalendar extends State<TaskaHorizontalCalendar> {
  @override
  Widget build(BuildContext) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index - 1));
          return Container(
            padding: EdgeInsets.only(left: index == 0 ? 0 : 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.all(10),
                maximumSize: Size(70, 140),
                minimumSize: Size(70, 140),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(
                    color:
                        DateFormat("MM dd").format(date) ==
                            DateFormat("MM dd").format(widget.selectedDay)
                        ? taskaBackground
                        : taskaBorder,
                  ),
                ),
                backgroundColor:
                    DateFormat("MM dd").format(date) ==
                        DateFormat("MM dd").format(widget.selectedDay)
                    ? taskaPurplish
                    : taskaBackground,
              ),
              onPressed: () {
                setState(() {
                  widget.selectedDay = date;
                  widget.onUpdate!(date);
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.d().format(date),
                    style: TextStyle(
                      fontSize: 30,
                      color:
                          DateFormat("MM dd").format(date) ==
                              DateFormat("MM dd").format(widget.selectedDay)
                          ? taskaBackground
                          : taskaTextGray,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    DateFormat.E("ru").format(date).toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      color:
                          DateFormat("MM dd").format(date) ==
                              DateFormat("MM dd").format(widget.selectedDay)
                          ? taskaBackground
                          : taskaTextGray,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
