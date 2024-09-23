import 'package:flutter/material.dart';
import 'package:football_app/pages/home.dart';
// import 'package:football_app/pages/teams.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  //init the hive
  await Hive.initFlutter();
  //open a box
  // ignore: unused_local_variable
  var box = await Hive.openBox('dataBox');

  runApp(const myApp());
}

// ignore: camel_case_types
class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 22, 36, 63)),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Allplayers(),
      },
      debugShowCheckedModeBanner: false,
    );
    
  }
}
