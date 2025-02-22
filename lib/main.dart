import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/pages/HomePage.dart';

void main() async {
  //init the hive
 await Hive.initFlutter();

  // create a box
  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: Homepage(),
      theme: ThemeData(
       primarySwatch: Colors.yellow,
      ),

    );
  }
}

