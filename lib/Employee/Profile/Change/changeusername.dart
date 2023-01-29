// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Login/login.dart';

class ChangeUsername extends StatefulWidget {
  ChangeUsername({Key? key}) : super(key: key);

  @override
  ChangeUsernameState createState() => ChangeUsernameState();
}

class ChangeUsernameState extends State<ChangeUsername> {
  List<TextEditingController> controllers =
      List.generate(2, (index) => TextEditingController());
  List<Map<String, dynamic>> employee = [];
  String error = '';

  void getData() async {
    await DB.openCon('employeelogin');
    employee =
        await DB.collection.find({'Username': LoginState.employee}).toList();
    await DB.closeCon();
    controllers[0].text = employee[0]['Username'];
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
        body: SizedBox(
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
                        'Change Username',
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
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Current Username',
                        labelStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.deepPurple.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.text_format_outlined,
                            color: Colors.deepPurple.shade500),
                        prefixIconColor: Colors.deepPurple.shade500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: 750,
                    child: TextField(
                        controller: controllers[1],
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'New Username',
                          labelStyle: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.deepPurple.shade500,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          errorText: error == 'empty'
                              ? 'Username Can\'t be empty'
                              : error == 'minimum'
                                  ? 'Minimum Limit is not Reached'
                                  : error == 'maximum'
                                      ? 'Maximum Limit is Exceeded'
                                      : error == 'already exist'
                                          ? 'Username already exist'
                                          : null,
                          prefixIcon: Icon(Icons.text_format_outlined,
                              color: Colors.deepPurple.shade500),
                          prefixIconColor: Colors.deepPurple.shade500,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              if (value.length < 8) {
                                error = 'minimum';
                              } else if (value.length > 20) {
                                error = 'maximum';
                              } else {
                                error = '';
                              }
                            }
                          });
                        }),
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: 750,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GFButton(
                            onPressed: () async {
                              setState(() {
                                if (controllers[1].text.isEmpty) {
                                  error = 'empty';
                                }
                              });
                              if (error == '') {
                                await DB.openCon('employeelogin');
                                employee = await DB.collection.find().toList();
                                await DB.closeCon();
                                setState(() {
                                  for (int i = 0; i < employee.length; i++) {
                                    if (controllers[1].text ==
                                        employee[i]['Username']) {
                                      error = 'already exist';
                                      break;
                                    }
                                  }
                                });
                                if (error == '') {
                                  await DB.openCon('employeelogin');
                                  await DB.updatedata(
                                      'Username',
                                      controllers[0].text,
                                      'Username',
                                      controllers[1].text);
                                  await DB.closeCon();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              }
                            },
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            text: 'Confirm',
                            textColor: Colors.white,
                            color: Colors.deepPurple.shade700,
                            hoverColor: Colors.deepPurple.shade500,
                            shape: GFButtonShape.square,
                            size: GFSize.LARGE,
                          ),
                        ]),
                  ),
                ])));
  }
}