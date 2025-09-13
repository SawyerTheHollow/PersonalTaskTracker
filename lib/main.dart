import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const App());
}


/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 80),
              child:ElevatedButton(onPressed: (){},
                  child: Text("Продолжить", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
                style: ElevatedButton.styleFrom(minimumSize: Size(300, 80), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: Colors.indigoAccent) ,
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/