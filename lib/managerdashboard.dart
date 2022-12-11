// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ManagerDashboard extends StatefulWidget {
  ManagerDashboard({Key? key}) : super(key: key);

  @override
  ManagerDashboardState createState() => ManagerDashboardState();
}

class ManagerDashboardState extends State<ManagerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Manager Dashboard'),
            GFButton(onPressed: () {
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  }
}
