import 'package:first_flutter_project/data/api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage;
  App({super.key, required this.apiClient, required this.secureStorage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taska',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: SplashScreen(apiClient: apiClient, secureStorage: secureStorage,)
    );
  }
}
