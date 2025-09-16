import 'package:flutter/material.dart';
import 'package:first_flutter_project/data/api/api_client.dart';

class DashboardScreen extends StatefulWidget {
  final ApiClient apiClient;
  DashboardScreen({Key? key, required this.apiClient});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

const myThemeColor = Color(0xFF665EE2);

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text("Успех!")],),);
  }
}