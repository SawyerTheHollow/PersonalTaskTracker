import 'package:first_flutter_project/api/api_client.dart';
import 'package:flutter/material.dart';

import 'injection/service_locator.dart';
import 'ui/screens/splash_screen.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = getIt<ApiClient>;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taska',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: SplashScreen(),
    );
  }
}
