 import 'package:flutter/material.dart';
import 'package:mercadinho_app/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RR Center',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 56, 51, 163)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}
