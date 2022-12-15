// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors

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
        child: Row(
          children: [
            Container(
              // color: Colors.deepPurple[200],
              color: Colors.black,
              width: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: GFButton(
                      icon: Icon(Icons.dashboard, color: Colors.white),
                      text: 'Dashboard',
                      textStyle: TextStyle(fontSize: 20),
                      color: Colors.deepPurple.shade700,
                      shape: GFButtonShape.pills,
                      type: GFButtonType.outline2x,
                      size: GFSize.LARGE,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: GFButton(
                      icon: Icon(Icons.manage_accounts, color: Colors.white),
                      text: 'Manager',
                      textStyle: TextStyle(fontSize: 20),
                      color: Colors.deepPurple.shade700,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: GFButton(
                      icon: Icon(Icons.emoji_people, color: Colors.white),
                      text: 'Employee',
                      textStyle: TextStyle(fontSize: 20),
                      color: Colors.deepPurple.shade700,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: GFButton(
                      icon: Icon(Icons.car_repair, color: Colors.white),
                      text: 'Product',
                      textStyle: TextStyle(fontSize: 20),
                      color: Colors.deepPurple.shade700,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: GFButton(
                      icon: Icon(Icons.store, color: Colors.white),
                      text: 'Shop',
                      textStyle: TextStyle(fontSize: 20),
                      color: Colors.deepPurple.shade700,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: GFButton(
                      icon: Icon(Icons.production_quantity_limits,
                          color: Colors.white),
                      text: 'Stock',
                      textStyle: TextStyle(fontSize: 20),
                      color: Colors.deepPurple.shade700,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: GFButton(
                      icon: Icon(Icons.manage_accounts, color: Colors.white),
                      text: 'Sales',
                      textStyle: TextStyle(fontSize: 20),
                      color: Colors.deepPurple.shade700,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
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
            Column()
          ],
        ),
      ),
    );
  }
}
