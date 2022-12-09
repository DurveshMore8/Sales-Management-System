// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String selected = 'manager';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        title: Text('Tata Motors'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Colors.deepPurple[500],
          height: 500,
          width: 800,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Login Page',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: selected == 'manager'
                      ? Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GFButton(
                                onPressed: () {},
                                text: 'Manager Login',
                                textColor: Colors.white,
                                color: Colors.deepPurple.shade700,
                                shape: GFButtonShape.square,
                                type: GFButtonType.outline2x,
                                size: GFSize.LARGE,
                                padding: EdgeInsets.only(left: 150, right: 150),
                              ),
                              GFButton(
                                onPressed: () {
                                  selected = 'employee';
                                  Login();
                                },
                                text: 'Employee Login',
                                color: Colors.deepPurple.shade700,
                                shape: GFButtonShape.square,
                                size: GFSize.LARGE,
                                padding: EdgeInsets.only(left: 150, right: 150),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GFButton(
                                onPressed: () {
                                  selected = 'manager';
                                },
                                text: 'Manager Login',
                                color: Colors.deepPurple.shade700,
                                shape: GFButtonShape.square,
                                size: GFSize.LARGE,
                                padding: EdgeInsets.only(left: 150, right: 150),
                              ),
                              GFButton(
                                onPressed: () {
                                  selected = 'employee';
                                },
                                text: 'Employee Login',
                                textColor: Colors.white,
                                color: Colors.deepPurple.shade700,
                                shape: GFButtonShape.square,
                                type: GFButtonType.outline2x,
                                size: GFSize.LARGE,
                                padding: EdgeInsets.only(left: 150, right: 150),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
