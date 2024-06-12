import 'package:flutter/material.dart';
import 'package:space_pod/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      theme: ThemeData(
        //fontFamily: 'font2',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 27, 8, 8),
        primaryColor: Colors.deepPurple.shade300,
      ),
    );
  }
}
