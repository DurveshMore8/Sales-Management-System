// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Dashboard/employeedashboard.dart';
import 'package:sales_management_system/Employee/Profile/editprofile.dart';
import 'package:sales_management_system/Employee/sales.dart';
import 'package:sales_management_system/Employee/stock.dart';
import 'package:sales_management_system/Login/login.dart';

class EmployeeNavigationBar extends StatefulWidget {
  EmployeeNavigationBar({Key? key}) : super(key: key);

  @override
  _EmployeeNavigationBarState createState() => _EmployeeNavigationBarState();
}

class _EmployeeNavigationBarState extends State<EmployeeNavigationBar> {
  Widget currentFunction = EmployeeDashboard();
  String currentState = 'EmployeeDashboard';
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: expanded
          ? Row(
              children: [
                Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              expanded = !expanded;
                            });
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 260,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: Text(
                                LoginState.employee[0].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(LoginState.employee,
                                key: Key('EmployeeName'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 10),
                            TextButton(
                              child: Text(
                                'Edit Profile',
                                key: Key('EditProfile'),
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => EditProfile())));
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                          width: 260,
                          height: 50,
                          child: currentState == 'EmployeeDashboard'
                              ? GFButton(
                                  icon: Icon(Icons.dashboard,
                                      color: Colors.white),
                                  text: 'Dashboard',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.pills,
                                  type: GFButtonType.outline2x,
                                  size: GFSize.LARGE,
                                  onPressed: () {},
                                )
                              : GFButton(
                                  icon: Icon(Icons.dashboard,
                                      color: Colors.white),
                                  text: 'Dashboard',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.square,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = EmployeeDashboard();
                                      currentState = 'EmployeeDashboard';
                                    });
                                  },
                                )),
                      SizedBox(height: 30),
                      SizedBox(
                          width: 260,
                          height: 50,
                          child: currentState == 'Stock'
                              ? GFButton(
                                  icon: Icon(Icons.production_quantity_limits,
                                      color: Colors.white),
                                  text: 'Stock',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.pills,
                                  type: GFButtonType.outline2x,
                                  size: GFSize.LARGE,
                                  onPressed: () {},
                                )
                              : GFButton(
                                  icon: Icon(Icons.production_quantity_limits,
                                      color: Colors.white),
                                  text: 'Stock',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.square,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Stock();
                                      currentState = 'Stock';
                                    });
                                  },
                                )),
                      SizedBox(height: 30),
                      SizedBox(
                          width: 260,
                          height: 50,
                          child: currentState == 'Sales'
                              ? GFButton(
                                  icon: Icon(Icons.point_of_sale,
                                      color: Colors.white),
                                  text: 'Sales',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.pills,
                                  type: GFButtonType.outline2x,
                                  size: GFSize.LARGE,
                                  onPressed: () {},
                                )
                              : GFButton(
                                  icon: Icon(Icons.point_of_sale,
                                      color: Colors.white),
                                  text: 'Sales',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.square,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Sales();
                                      currentState = 'Sales';
                                    });
                                  },
                                )),
                      SizedBox(height: 30),
                      SizedBox(
                        width: 260,
                        height: 50,
                        child: GFButton(
                          icon: Icon(Icons.logout, color: Colors.white),
                          text: 'Log Out',
                          textStyle: TextStyle(fontSize: 20),
                          color: Colors.deepPurple.shade700,
                          shape: GFButtonShape.square,
                          size: GFSize.LARGE,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 260,
                  child: currentFunction,
                )
              ],
            )
          : Row(children: [
              Container(
                color: Colors.black,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              expanded = !expanded;
                            });
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: Text(
                                LoginState.employee[0].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 40),
                            TextButton(
                              child: Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => EditProfile())));
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: currentState == 'EmployeeDashboard'
                              ? GFIconButton(
                                  icon: Icon(Icons.dashboard,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  type: GFButtonType.outline2x,
                                  onPressed: () {},
                                )
                              : GFIconButton(
                                  icon: Icon(Icons.dashboard,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = EmployeeDashboard();
                                      currentState = 'EmployeeDashboard';
                                    });
                                  },
                                )),
                      SizedBox(height: 30),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: currentState == 'Stock'
                              ? GFIconButton(
                                  icon: Icon(Icons.production_quantity_limits,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  type: GFButtonType.outline2x,
                                  onPressed: () {},
                                )
                              : GFIconButton(
                                  icon: Icon(Icons.production_quantity_limits,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Stock();
                                      currentState = 'Stock';
                                    });
                                  },
                                )),
                      SizedBox(height: 30),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: currentState == 'Sales'
                              ? GFIconButton(
                                  icon: Icon(Icons.point_of_sale,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  type: GFButtonType.outline2x,
                                  onPressed: () {},
                                )
                              : GFIconButton(
                                  icon: Icon(Icons.point_of_sale,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Sales();
                                      currentState = 'Sales';
                                    });
                                  },
                                )),
                      SizedBox(height: 30),
                      SizedBox(
                        width: 60,
                        height: 50,
                        child: GFIconButton(
                          icon: Icon(Icons.logout, color: Colors.white),
                          color: Colors.deepPurple.shade700,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: currentFunction,
              )
            ]),
    );
  }
}
