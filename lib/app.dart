import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taska',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: SplashScreen()
    );
  }
}
