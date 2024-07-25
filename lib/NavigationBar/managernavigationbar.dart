// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Dashboard/managerdashboard.dart';
import 'package:sales_management_system/Login/login.dart';
import 'package:sales_management_system/Manager/employee.dart';
import 'package:sales_management_system/Manager/manager.dart';
import 'package:sales_management_system/Manager/product.dart';
import 'package:sales_management_system/Manager/sales.dart';
import 'package:sales_management_system/Manager/branch.dart';
import 'package:sales_management_system/Manager/stock.dart';
import 'package:sales_management_system/Manager/Profile/editprofile.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  Widget currentFunction = ManagerDashboard();
  String currentState = 'ManagerDashboard';
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
                          key: Key('Menu'),
                          onPressed: () {
                            setState(() {
                              expanded = !expanded;
                            });
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: 260,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: Text(
                                LoginState.manager[0].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(LoginState.manager,
                                key: Key('ManagerName'),
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
                      SizedBox(height: 30),
                      SizedBox(
                          width: 260,
                          height: 50,
                          child: currentState == 'ManagerDashboard'
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
                                  key: Key('Dashboard'),
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.square,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = ManagerDashboard();
                                      currentState = 'ManagerDashboard';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
                      SizedBox(
                          width: 260,
                          height: 50,
                          child: currentState == 'Manager'
                              ? GFButton(
                                  icon: Icon(Icons.manage_accounts,
                                      color: Colors.white),
                                  text: 'Manager',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.pills,
                                  type: GFButtonType.outline2x,
                                  size: GFSize.LARGE,
                                  onPressed: () {},
                                )
                              : GFButton(
                                  icon: Icon(Icons.manage_accounts,
                                      color: Colors.white),
                                  text: 'Manager',
                                  key: Key('Manager'),
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.square,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Manager();
                                      currentState = 'Manager';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
                      SizedBox(
                          width: 260,
                          height: 50,
                          child: currentState == 'Employee'
                              ? GFButton(
                                  icon: Icon(Icons.emoji_people,
                                      color: Colors.white),
                                  text: 'Employee',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.pills,
                                  type: GFButtonType.outline2x,
                                  size: GFSize.LARGE,
                                  onPressed: () {},
                                )
                              : GFButton(
                                  icon: Icon(Icons.emoji_people,
                                      color: Colors.white),
                                  text: 'Employee',
                                  key: Key('Employee'),
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.square,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Employee();
                                      currentState = 'Employee';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
                      SizedBox(
                          width: 260,
                          height: 50,
                          child: currentState == 'Product'
                              ? GFButton(
                                  icon: Icon(Icons.car_repair,
                                      color: Colors.white),
                                  text: 'Product',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.pills,
                                  type: GFButtonType.outline2x,
                                  size: GFSize.LARGE,
                                  onPressed: () {},
                                )
                              : GFButton(
                                  icon: Icon(Icons.car_repair,
                                      color: Colors.white),
                                  text: 'Product',
                                  key: Key('Product'),
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.square,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Product();
                                      currentState = 'Product';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
                      SizedBox(
                          width: 260,
                          height: 50,
                          child: currentState == 'Branch'
                              ? GFButton(
                                  icon: Icon(Icons.store, color: Colors.white),
                                  text: 'Branch',
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.pills,
                                  type: GFButtonType.outline2x,
                                  size: GFSize.LARGE,
                                  onPressed: () {},
                                )
                              : GFButton(
                                  icon: Icon(Icons.store, color: Colors.white),
                                  text: 'Branch',
                                  key: Key('Branch'),
                                  textStyle: TextStyle(fontSize: 20),
                                  color: Colors.deepPurple.shade700,
                                  shape: GFButtonShape.square,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Branch();
                                      currentState = 'Branch';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
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
                                  key: Key('Stock'),
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
                      SizedBox(height: 10),
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
                                  key: Key('Sales'),
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
                      SizedBox(height: 10),
                      SizedBox(
                        width: 260,
                        height: 50,
                        child: GFButton(
                          icon: Icon(Icons.logout, color: Colors.white),
                          text: 'Log Out',
                          key: Key('Log Out'),
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
                          key: Key('Menu'),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: Text(
                                LoginState.manager[0].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 40),
                            TextButton(
                              child: Text(
                                'Edit',
                                key: Key('Edit'),
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
                      SizedBox(height: 30),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: currentState == 'ManagerDashboard'
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
                                      currentFunction = ManagerDashboard();
                                      currentState = 'ManagerDashboard';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: currentState == 'Manager'
                              ? GFIconButton(
                                  icon: Icon(Icons.manage_accounts,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  type: GFButtonType.outline2x,
                                  onPressed: () {},
                                )
                              : GFIconButton(
                                  icon: Icon(Icons.manage_accounts,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Manager();
                                      currentState = 'Manager';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: currentState == 'Employee'
                              ? GFIconButton(
                                  icon: Icon(Icons.emoji_people,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  type: GFButtonType.outline2x,
                                  onPressed: () {},
                                )
                              : GFIconButton(
                                  icon: Icon(Icons.emoji_people,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Employee();
                                      currentState = 'Employee';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: currentState == 'Product'
                              ? GFIconButton(
                                  icon: Icon(Icons.car_repair,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  type: GFButtonType.outline2x,
                                  onPressed: () {},
                                )
                              : GFIconButton(
                                  icon: Icon(Icons.car_repair,
                                      color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Product();
                                      currentState = 'Product';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: currentState == 'Branch'
                              ? GFIconButton(
                                  icon: Icon(Icons.store, color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  type: GFButtonType.outline2x,
                                  onPressed: () {},
                                )
                              : GFIconButton(
                                  icon: Icon(Icons.store, color: Colors.white),
                                  color: Colors.deepPurple.shade700,
                                  onPressed: () {
                                    setState(() {
                                      currentFunction = Branch();
                                      currentState = 'Branch';
                                    });
                                  },
                                )),
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
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
