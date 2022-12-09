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
      backgroundColor: Colors.deepPurple[400],
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
                Text(
                  'Login Page',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  child: selected == 'manager'
                      ? Row(
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
                              hoverColor: Colors.deepPurple.shade500,
                              padding: EdgeInsets.only(left: 150, right: 150),
                            ),
                            GFButton(
                              onPressed: () {
                                setState(() {
                                  selected = 'employee';
                                });
                              },
                              text: 'Employee Login',
                              color: Colors.deepPurple.shade700,
                              shape: GFButtonShape.square,
                              size: GFSize.LARGE,
                              padding: EdgeInsets.only(left: 150, right: 150),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GFButton(
                              onPressed: () {
                                setState(() {
                                  selected = 'manager';
                                });
                              },
                              text: 'Manager Login',
                              color: Colors.deepPurple.shade700,
                              shape: GFButtonShape.square,
                              size: GFSize.LARGE,
                              padding: EdgeInsets.only(left: 150, right: 150),
                            ),
                            GFButton(
                              onPressed: () {},
                              text: 'Employee Login',
                              textColor: Colors.white,
                              color: Colors.deepPurple.shade700,
                              hoverColor: Colors.deepPurple.shade500,
                              shape: GFButtonShape.square,
                              type: GFButtonType.outline2x,
                              size: GFSize.LARGE,
                              padding: EdgeInsets.only(left: 150, right: 150),
                            ),
                          ],
                        ),
                ),
                GFTextFieldSquared(
                    backgroundcolor: Colors.white,
                    editingbordercolor: Colors.white,
                    idlebordercolor: Colors.white,
                    borderwidth: 1,
                    hintText: 'Enter ManagerName')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
