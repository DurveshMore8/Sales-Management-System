// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/NavigationBar/employeenavigationbar.dart';
import 'package:sales_management_system/NavigationBar/managernavigationbar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String selected = 'manager';
  bool visible = true;
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  List<String> error = List.generate(5, (index) => '');
  bool valid = true;
  bool isLoading = false;
  static String manager = '';
  static String employee = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          : Center(
              child: Container(
                color: Colors.deepPurple[500],
                height: 550,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    padding:
                                        EdgeInsets.only(left: 150, right: 150),
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
                                    padding:
                                        EdgeInsets.only(left: 150, right: 150),
                                  ),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    padding:
                                        EdgeInsets.only(left: 150, right: 150),
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
                                    padding:
                                        EdgeInsets.only(left: 150, right: 150),
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
                                        controller: controllers[0],
                                        key: Key('M-Username'),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: '@AbcPqr12',
                                          labelText: 'Username',
                                          labelStyle: TextStyle(
                                              backgroundColor: Colors.white,
                                              color: Colors.deepPurple.shade500,
                                              fontWeight: FontWeight.bold),
                                          errorText: error[0] == 'empty'
                                              ? 'Name Can\'t be empty'
                                              : error[0] == 'minimum'
                                                  ? 'Minimum Limit is not Reached'
                                                  : error[0] == 'maximum'
                                                      ? 'Maximum Limit is Exceeded'
                                                      : null,
                                          prefixIcon: Icon(
                                              Icons.text_format_outlined,
                                              color:
                                                  Colors.deepPurple.shade500),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value.isNotEmpty) {
                                              if (value.length < 8) {
                                                error[0] = 'minimum';
                                              } else if (value.length > 30) {
                                                error[0] = 'maximum';
                                              } else {
                                                error[0] = '';
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    error[0] == ''
                                        ? SizedBox(height: 34)
                                        : SizedBox(height: 10),
                                    SizedBox(
                                      width: 750,
                                      child: TextField(
                                        controller: controllers[1],
                                        key: Key('M-EmailId'),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: 'something@gmail.com',
                                          labelText: 'Email Id',
                                          labelStyle: TextStyle(
                                              backgroundColor: Colors.white,
                                              color: Colors.deepPurple.shade500,
                                              fontWeight: FontWeight.bold),
                                          errorText: error[1] == 'empty'
                                              ? 'Email Id Can\'t be empty'
                                              : error[1] == 'invalid'
                                                  ? 'Invalid Email Id'
                                                  : null,
                                          prefixIcon: Icon(Icons.email_outlined,
                                              color:
                                                  Colors.deepPurple.shade500),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            if (EmailValidator.validate(
                                                controllers[1].text)) {
                                              error[1] = '';
                                            } else {
                                              error[1] = 'invalid';
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    error[1] == ''
                                        ? SizedBox(height: 34)
                                        : SizedBox(height: 10),
                                    SizedBox(
                                      width: 750,
                                      child: TextField(
                                        controller: controllers[2],
                                        key: Key('M-Password'),
                                        obscureText: visible,
                                        obscuringCharacter: '*',
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: '@password',
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                              backgroundColor: Colors.white,
                                              color: Colors.deepPurple.shade500,
                                              fontWeight: FontWeight.bold),
                                          errorText: error[2] == 'empty'
                                              ? 'Password Can\'t be empty'
                                              : error[2] == 'minimum'
                                                  ? 'Minimum Limit is not Reached'
                                                  : error[2] == 'maximum'
                                                      ? 'Maximum Limit is Exceeded'
                                                      : error[2] == 'wrong'
                                                          ? 'Wrong Credentials Entered'
                                                          : null,
                                          prefixIcon: Icon(Icons.lock_outlined,
                                              color:
                                                  Colors.deepPurple.shade500),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  visible = !visible;
                                                });
                                              },
                                              icon: Icon(
                                                visible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color:
                                                    Colors.deepPurple.shade500,
                                              )),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value.isNotEmpty) {
                                              if (value.length < 8) {
                                                error[2] = 'minimum';
                                              } else if (value.length > 40) {
                                                error[2] = 'maximum';
                                              } else {
                                                error[2] = '';
                                              }
                                            }
                                          });
                                        },
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
                                          controller: controllers[3],
                                          key: Key('E-Username'),
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: '@AbcPqr12',
                                            labelText: 'Username',
                                            labelStyle: TextStyle(
                                                backgroundColor: Colors.white,
                                                color:
                                                    Colors.deepPurple.shade500,
                                                fontWeight: FontWeight.bold),
                                            errorText: error[3] == 'empty'
                                                ? 'Username Can\'t be empty'
                                                : error[3] == 'minimum'
                                                    ? 'Minimum Limit is not Reached'
                                                    : error[3] == 'maximum'
                                                        ? 'Maximum Limit is Exceeded'
                                                        : null,
                                            prefixIcon: Icon(
                                                Icons.text_format_outlined,
                                                color:
                                                    Colors.deepPurple.shade500),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.horizontal(),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value.isNotEmpty) {
                                                if (value.length < 8) {
                                                  error[3] = 'minimum';
                                                } else if (value.length > 30) {
                                                  error[3] = 'maximum';
                                                } else {
                                                  error[3] = '';
                                                }
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      error[3] == ''
                                          ? SizedBox(height: 39)
                                          : SizedBox(height: 15),
                                      SizedBox(
                                        width: 750,
                                        child: TextField(
                                          controller: controllers[4],
                                          key: Key('E-Password'),
                                          obscureText: visible,
                                          obscuringCharacter: '*',
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: '@password',
                                            labelText: 'Password',
                                            labelStyle: TextStyle(
                                                backgroundColor: Colors.white,
                                                color:
                                                    Colors.deepPurple.shade500,
                                                fontWeight: FontWeight.bold),
                                            errorText: error[4] == 'empty'
                                                ? 'Password Can\'t be empty'
                                                : error[4] == 'minimum'
                                                    ? 'Minimum Limit is not Reached'
                                                    : error[4] == 'maximum'
                                                        ? 'Maximum Limit is Exceeded'
                                                        : error[4] == 'wrong'
                                                            ? 'Wrong Credentials Entered'
                                                            : null,
                                            prefixIcon: Icon(
                                                Icons.lock_outlined,
                                                color:
                                                    Colors.deepPurple.shade500),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    visible = !visible;
                                                  });
                                                },
                                                icon: Icon(
                                                    visible
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Colors
                                                        .deepPurple.shade500)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.horizontal(),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value.isNotEmpty) {
                                                if (value.length < 8) {
                                                  error[4] = 'minimum';
                                                } else if (value.length > 40) {
                                                  error[4] = 'maximum';
                                                } else {
                                                  error[4] = '';
                                                }
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ])),
                      selected == 'manager'
                          ? error[2] == ''
                              ? SizedBox(height: 34)
                              : SizedBox(height: 10)
                          : error[4] == ''
                              ? SizedBox(height: 44)
                              : SizedBox(height: 20),
                      //Functioning Buttons
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GFButton(
                              onPressed: () async {
                                //manager button clicked
                                valid = true;
                                setState(() {
                                  for (int i = 0; i < 3; i++) {
                                    if (controllers[i].text == '') {
                                      error[i] = 'empty';
                                    }
                                  }
                                  for (int i = 0; i < 3; i++) {
                                    if (controllers[i].text == '' ||
                                        error[i] != '') {
                                      valid = false;
                                    }
                                  }
                                });
                                if (valid) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (selected == 'manager') {
                                    await DB.openCon('managerlogin');
                                    var value = await DB.collection.find({
                                      'Username': controllers[0].text,
                                      'EmailId': controllers[1].text,
                                      'Password': controllers[2].text
                                    }).toList();
                                    await DB.closeCon();
                                    if (value.length == 0) {
                                      controllers[2].clear();
                                      error[2] = 'wrong';
                                    } else {
                                      manager = controllers[0].text;
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyNavigationBar()))
                                          .whenComplete(() {
                                        controllers[0].clear();
                                        controllers[1].clear();
                                        controllers[2].clear();
                                        for (int i = 0; i < 5; i++) {
                                          error[i] = '';
                                        }
                                      });
                                    }
                                  }
                                } else {
                                  valid = true;
                                  setState(() {
                                    for (int i = 3; i < 5; i++) {
                                      if (controllers[i].text == '') {
                                        error[i] = 'empty';
                                      }
                                    }
                                    for (int i = 3; i < 5; i++) {
                                      if (controllers[i].text == '' ||
                                          error[i] != '') {
                                        valid = false;
                                      }
                                    }
                                  });
                                  if (valid) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await DB.openCon('employeelogin');
                                    var value = await DB.collection.find({
                                      'Username': controllers[3].text,
                                      'Password': controllers[4].text
                                    }).toList();
                                    await DB.closeCon();
                                    if (value.length == 0) {
                                      controllers[4].clear();
                                      setState(() {
                                        error[4] = 'wrong';
                                      });
                                    } else {
                                      employee = controllers[3].text;
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EmployeeNavigationBar()))
                                          .whenComplete(
                                        () {
                                          controllers[3].clear();
                                          controllers[4].clear();
                                          for (int i = 0; i < 5; i++) {
                                            error[i] = '';
                                          }
                                        },
                                      );
                                    }
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              icon: Icon(
                                Icons.login,
                                color: Colors.green,
                              ),
                              text: 'Yes, LogIn',
                              key: Key("Login"),
                              textColor: Colors.white,
                              color: Colors.deepPurple.shade700,
                              hoverColor: Colors.deepPurple.shade500,
                              shape: GFButtonShape.square,
                              size: GFSize.LARGE,
                            ),
                            GFButton(
                              onPressed: () {
                                if (selected == 'manager') {
                                  controllers[0].clear();
                                  controllers[1].clear();
                                  controllers[2].clear();
                                } else {
                                  controllers[3].clear();
                                  controllers[4].clear();
                                }
                                for (int i = 0; i < 5; i++) {
                                  error[i] = '';
                                }
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              text: 'No, Clear',
                              key: Key('Clear'),
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
