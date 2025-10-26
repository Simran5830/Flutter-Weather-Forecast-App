import 'package:flutter/material.dart';
import 'package:flutter_weather/home.dart';

void main() {

  runApp(const MyApp());
}

// 1a2ce4b4199265b36a5d0b6f10cb5a01


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}