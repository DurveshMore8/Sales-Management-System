// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Login/login.dart';

class EmployeeDashboard extends StatefulWidget {
  EmployeeDashboard({Key? key}) : super(key: key);

  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  bool isLoading = false;
  Map<String, dynamic> employee = {};

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await DB.openCon('employeeinfo');
    var data =
        await DB.collection.find({'Username': LoginState.employee}).toList();
    await DB.closeCon();
    employee = data[0];
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade400,
        body: isLoading
            ? BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2,
                  sigmaY: 2,
                ),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Row(
                      children: [
                        SizedBox(width: 50),
                        Text(
                          'Hello, ${employee['Name']}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ));
  }
}
