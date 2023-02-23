// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:sadms/Login/login.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
