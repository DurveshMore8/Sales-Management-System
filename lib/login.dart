// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/database/database.dart';
import 'package:sadms/managerdashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String selected = 'manager';
  bool visible = true;
  var managername = TextEditingController();
  var emailid = TextEditingController();
  var mpassword = TextEditingController();
  var employeename = TextEditingController();
  var epassword = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Title
                SizedBox(height: 50),
                Text(
                  'Login Page',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                //Type Selection Buttons
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
                SizedBox(
                  height: 30,
                ),
                Container(
                    child: selected == 'manager'
                        ? Column(
                            //Manager TextFields
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 750,
                                child: TextField(
                                  controller: managername,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '@AbcPqr12',
                                    labelText: 'Enter ManagerName',
                                    prefixIcon:
                                        Icon(Icons.text_format_outlined),
                                    prefixIconColor: Colors.deepPurple.shade500,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: 750,
                                child: TextField(
                                  controller: emailid,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'something@gmail.com',
                                    labelText: 'Enter Email Id',
                                    prefixIcon: Icon(Icons.email_outlined),
                                    prefixIconColor: Colors.deepPurple.shade500,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: 750,
                                child: TextField(
                                  controller: mpassword,
                                  obscureText: visible,
                                  obscuringCharacter: '*',
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '@password',
                                    labelText: 'Enter Password',
                                    prefixIcon: Icon(Icons.lock_outlined),
                                    prefixIconColor: Colors.deepPurple.shade500,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            visible = !visible;
                                          });
                                        },
                                        icon: Icon(visible
                                            ? Icons.visibility_off
                                            : Icons.visibility)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            //Employee TextFields
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                SizedBox(
                                  width: 750,
                                  child: TextField(
                                    controller: employeename,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '@AbcPqr12',
                                      labelText: 'Enter EmployeeName',
                                      prefixIcon:
                                          Icon(Icons.text_format_outlined),
                                      prefixIconColor:
                                          Colors.deepPurple.shade500,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: 750,
                                  child: TextField(
                                    controller: epassword,
                                    obscureText: visible,
                                    obscuringCharacter: '*',
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '@password',
                                      labelText: 'Enter Password',
                                      prefixIcon: Icon(Icons.lock_outlined),
                                      prefixIconColor:
                                          Colors.deepPurple.shade500,
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              visible = !visible;
                                            });
                                          },
                                          icon: Icon(visible
                                              ? Icons.visibility_off
                                              : Icons.visibility)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(),
                                      ),
                                    ),
                                  ),
                                ),
                              ])),
                SizedBox(height: 20),
                //Functioning Buttons
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GFButton(
                        onPressed: () async {
                          //manager button clicked
                          if (selected == 'manager') {
                            await DB.openCon('managerlogin');
                            var value = await DB.collection.find({
                              'ManagerName': managername.text,
                              'EmailId': emailid.text,
                              'Password': mpassword.text
                            }).toList();
                            await DB.closeCon();
                            if (value.length == 0) {
                              mpassword.clear();
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManagerDashboard()));
                            }
                          } else {
                            await DB.openCon('employeelogin');
                            var value = await DB.collection.find({
                              'EmployeeName': employeename.text,
                              'Password': epassword.text
                            }).toList();
                            await DB.closeCon();
                            if (value.length == 0) {
                              epassword.clear();
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManagerDashboard()));
                            }
                          }
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        text: 'Yes, LogIn',
                        textColor: Colors.white,
                        color: Colors.deepPurple.shade700,
                        hoverColor: Colors.deepPurple.shade500,
                        shape: GFButtonShape.square,
                        size: GFSize.LARGE,
                      ),
                      GFButton(
                        onPressed: () {
                          if (selected == 'manager') {
                            managername.clear();
                            emailid.clear();
                            mpassword.clear();
                          } else {
                            employeename.clear();
                            epassword.clear();
                          }
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        text: 'No, Clear',
                        textColor: Colors.white,
                        color: Colors.deepPurple.shade700,
                        hoverColor: Colors.deepPurple.shade500,
                        shape: GFButtonShape.square,
                        size: GFSize.LARGE,
                      )
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
