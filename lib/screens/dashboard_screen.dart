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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 30, // например, 30 дней
              itemBuilder: (context, index) {
                DateTime date = DateTime.now().add(Duration(days: index));
                return Container(
                  width: 60,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.E().format(
                          date,
                        ), // день недели, например "Mon"
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Text(
                        DateFormat.d().format(date), // число месяца
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
    );
  }
}
