import 'package:first_flutter_project/ui/shared/taska_text_form_field.dart';
import 'package:first_flutter_project/ui/shared/taska_title_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

const myThemeColor = Color(0xFF665EE2);

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Мои задачи"),
        centerTitle: true,
        backgroundColor: Color(0xFFF8F7FD),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                Icon(Icons.calendar_month),
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
                      //  border: Border.all(color: Color(0xFFE7EFFD)),
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
