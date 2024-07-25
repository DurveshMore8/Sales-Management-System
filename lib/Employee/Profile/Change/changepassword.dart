// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Login/login.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());
  List<bool> visible = List.generate(3, (index) => true);
  List<String> error = ['', '', ''];
  List<Map<String, dynamic>> employee = [];
  bool valid = true;
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await DB.openCon('employeelogin');
    employee =
        await DB.collection.find({'Username': LoginState.employee}).toList();
    await DB.closeCon();
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
      backgroundColor: Colors.deepPurple[400],
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
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.white,
                            )),
                        Text(
                          'Change Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    SizedBox(
                      width: 750,
                      child: TextField(
                        controller: controllers[0],
                        key: Key('Current'),
                        obscureText: visible[0],
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Current Password',
                          labelText: 'Current Password',
                          labelStyle: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.deepPurple.shade500,
                              fontWeight: FontWeight.bold),
                          errorText: error[0] == 'notsame'
                              ? 'Incorrect Current Password'
                              : null,
                          prefixIcon: Icon(Icons.lock_outlined,
                              color: Colors.deepPurple.shade500),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visible[0] = !visible[0];
                                });
                              },
                              icon: Icon(
                                  visible[0]
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.deepPurple.shade500)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (controllers[0].text !=
                                employee[0]['Password']) {
                              error[0] = 'notsame';
                            } else {
                              error[0] = '';
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 750,
                      child: TextField(
                        controller: controllers[1],
                        key: Key('New'),
                        obscureText: visible[1],
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'New Password',
                          labelText: 'New Password',
                          labelStyle: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.deepPurple.shade500,
                              fontWeight: FontWeight.bold),
                          errorText: error[1] == 'empty'
                              ? 'New Password Can\'t be empty'
                              : error[1] == 'minimum'
                                  ? 'Minimum Limit is not Reached'
                                  : error[1] == 'maximum'
                                      ? 'Maximum Limit is Exceeded'
                                      : null,
                          prefixIcon: Icon(Icons.lock_outlined,
                              color: Colors.deepPurple.shade500),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visible[1] = !visible[1];
                                });
                              },
                              icon: Icon(
                                  visible[1]
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.deepPurple.shade500)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              if (value.length < 8) {
                                error[1] = 'minimum';
                              } else if (value.length > 40) {
                                error[1] = 'maximum';
                              } else {
                                error[1] = '';
                              }
                            }
                            if (controllers[0].text != controllers[1].text) {
                              error[2] = 'notsame';
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 750,
                      child: TextField(
                        controller: controllers[2],
                        key: Key('Confirm'),
                        obscureText: visible[2],
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.deepPurple.shade500,
                              fontWeight: FontWeight.bold),
                          errorText: error[2] == 'notsame'
                              ? 'Password doesn\'t Match'
                              : null,
                          prefixIcon: Icon(Icons.lock_outlined,
                              color: Colors.deepPurple.shade500),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visible[2] = !visible[2];
                                });
                              },
                              icon: Icon(
                                  visible[2]
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.deepPurple.shade500)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            setState(() {
                              if (controllers[1].text != controllers[2].text) {
                                error[2] = 'notsame';
                              } else {
                                error[2] = '';
                              }
                            });
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 100),
                    SizedBox(
                      width: 750,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GFButton(
                              onPressed: () async {
                                valid = true;
                                if (controllers[1].text.isEmpty) {
                                  error[1] = 'empty';
                                }
                                for (int i = 0; i < 3; i++) {
                                  if (error[i] != '') {
                                    valid = false;
                                    break;
                                  }
                                }
                                if (valid) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await DB.openCon('employeelogin');
                                  await DB.updatedata(
                                      'Password',
                                      controllers[0].text,
                                      'Password',
                                      controllers[1].text);
                                  await DB.closeCon();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              text: 'Confirm',
                              key: Key('Edit'),
                              textColor: Colors.white,
                              color: Colors.deepPurple.shade700,
                              hoverColor: Colors.deepPurple.shade500,
                              shape: GFButtonShape.square,
                              size: GFSize.LARGE,
                            ),
                          ]),
                    ),
                  ]),
            ),
    );
  }
}
