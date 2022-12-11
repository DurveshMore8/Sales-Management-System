// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class EmployeeDashboard extends StatefulWidget {
  EmployeeDashboard({Key? key}) : super(key: key);

  @override
  EmployeeDashboardState createState() => EmployeeDashboardState();
}

class EmployeeDashboardState extends State<EmployeeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Employee Dashboard'),
            GFButton(onPressed: () {
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  }
}
