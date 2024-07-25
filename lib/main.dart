// ignore_for_file: depend_on_referenced_packages, annotate_overrides

import 'package:flutter/material.dart';
import 'package:sales_management_system/Login/login.dart';
//import 'package:flutter_driver/driver_extension.dart';

void main() {
  //enableFlutterDriverExtension();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
