// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unused_catch_clause

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sales_management_system/Login/login.dart';
import 'package:sales_management_system/Manager/manager.dart';

class AddManager extends StatefulWidget {
  AddManager({Key? key}) : super(key: key);

  @override
  _AddManagerState createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {
  //name, username, phone, emailid, dob, branchname
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<String> error = ['', '', '', '', '', ''];
  List<String> branches = [
    ' Select Branch                                                                                  '
  ];
  int age = -1;
  String gender = 'a';
  bool valid = true;
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await DB.openCon('branch');
    List<Map<String, dynamic>> data = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      for (int i = 0; i < data.length; i++) {
        branches.add(data[i]['BranchName']);
      }
      branches.sort((a, b) => a.compareTo(b));
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    controllers[5].text =
        ' Select Branch                                                                                  ';
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
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
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
                          'Add Manager',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[0],
                            key: Key('Name'),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Durvesh More',
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              errorText: error[0] == 'empty'
                                  ? 'Name Can\'t be empty'
                                  : error[0] == 'minimum'
                                      ? 'Minimum Limit is not Reached'
                                      : error[0] == 'maximum'
                                          ? 'Maximum Limit is Exceeded'
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
                            ? SizedBox(height: 29)
                            : SizedBox(height: 5),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[1],
                            key: Key('Username'),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'durvesh8403',
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              errorText: error[1] == 'empty'
                                  ? 'Name Can\'t be empty'
                                  : error[1] == 'minimum'
                                      ? 'Minimum Limit is not Reached'
                                      : error[1] == 'maximum'
                                          ? 'Maximum Limit is Exceeded'
                                          : error[1] == 'already exist'
                                              ? 'Username already exist'
                                              : null,
                              prefixIcon: Icon(Icons.supervised_user_circle,
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
                                    error[1] = 'minimum';
                                  } else if (value.length > 20) {
                                    error[1] = 'maximum';
                                  } else {
                                    error[1] = '';
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        error[1] == ''
                            ? SizedBox(height: 29)
                            : SizedBox(height: 5),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[2],
                            key: Key('Mobile'),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: '1234567890',
                              labelText: 'Mobile Number',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              errorText: error[2] == 'empty'
                                  ? 'Mobile Number Can\'t be empty'
                                  : error[2] == 'invalid'
                                      ? 'Enter a 10 digit Mobile Number'
                                      : null,
                              prefixIcon: Icon(Icons.phone,
                                  color: Colors.deepPurple.shade500),
                              prefixIconColor: Colors.deepPurple.shade500,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.length < 10 || value.length > 10) {
                                  error[2] = 'invalid';
                                } else {
                                  error[2] = '';
                                }
                              });
                            },
                          ),
                        ),
                        error[2] == ''
                            ? SizedBox(height: 29)
                            : SizedBox(height: 5),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[3],
                            key: Key('EmailId'),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'something@gmail.com',
                              labelText: 'E-mail Id',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              errorText: error[3] == 'empty'
                                  ? 'Email Id Can\'t be empty'
                                  : error[3] == 'invalid'
                                      ? 'Invalid Email Id'
                                      : null,
                              prefixIcon: Icon(Icons.email,
                                  color: Colors.deepPurple.shade500),
                              prefixIconColor: Colors.deepPurple.shade500,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (EmailValidator.validate(
                                    controllers[3].text)) {
                                  error[3] = '';
                                } else {
                                  error[3] = 'invalid';
                                }
                              });
                            },
                          ),
                        ),
                        error[3] == ''
                            ? SizedBox(height: 29)
                            : SizedBox(height: 5),
                        SizedBox(
                          width: 600,
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 9),
                                SizedBox(
                                    child: Icon(Icons.person,
                                        color: Colors.deepPurple[500])),
                                SizedBox(width: 7),
                                SizedBox(
                                  width: 100,
                                  child: Text('Gender',
                                      style: TextStyle(
                                          color: Colors.deepPurple[500],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ListTile(
                                    title: Text('Male',
                                        style: TextStyle(
                                            color: Colors.deepPurple[500],
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    leading: GFRadio(
                                      value: 'Male',
                                      key: Key('Male'),
                                      groupValue: gender,
                                      activeBgColor: Colors.white,
                                      radioColor: Colors.deepPurple.shade500,
                                      activeBorderColor:
                                          Colors.deepPurple.shade900,
                                      inactiveBorderColor:
                                          Colors.deepPurple.shade900,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ListTile(
                                    title: Text('Female',
                                        style: TextStyle(
                                            color: Colors.deepPurple[500],
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                    leading: GFRadio(
                                      value: 'Female',
                                      key: Key('Female'),
                                      groupValue: gender,
                                      activeBgColor: Colors.white,
                                      radioColor: Colors.deepPurple.shade500,
                                      activeBorderColor:
                                          Colors.deepPurple.shade900,
                                      inactiveBorderColor:
                                          Colors.deepPurple.shade900,
                                      onChanged: ((value) {
                                        setState(() {
                                          gender = value;
                                        });
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        gender == ''
                            ? Container(
                                width: 575,
                                height: 29,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Gender Can\'t be unselected',
                                  style: TextStyle(
                                      color: Colors.red[700], fontSize: 12),
                                  textAlign: TextAlign.start,
                                ))
                            : SizedBox(height: 29),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[4],
                            key: Key('DOB'),
                            readOnly: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'YYYY/MM/DD',
                              labelText: 'Date',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              errorText: error[4] == 'empty'
                                  ? 'Date Can\'t be empty'
                                  : null,
                              prefixIcon: Icon(Icons.date_range,
                                  color: Colors.deepPurple.shade500),
                              prefixIconColor: Colors.deepPurple.shade500,
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.edit_calendar,
                                      key: Key('Calendar'),
                                      color: Colors.deepPurple.shade500),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    ).then((selectedDate) {
                                      setState(() {
                                        error[4] = '';
                                      });
                                      age = AgeCalculator.age(selectedDate!)
                                          .years;
                                      List<String> date =
                                          selectedDate.toString().split('');
                                      controllers[4].clear();
                                      for (int i = 0; i < 10; i++) {
                                        controllers[4].text += date[i];
                                      }
                                    });
                                  }),
                              suffixIconColor: Colors.deepPurple.shade500,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                            ),
                          ),
                        ),
                        error[4] == ''
                            ? SizedBox(height: 29)
                            : SizedBox(height: 5),
                        Container(
                          color: Colors.white,
                          width: 600,
                          child: Row(
                            children: [
                              SizedBox(width: 9),
                              SizedBox(
                                  child: Icon(Icons.store,
                                      color: Colors.deepPurple[500])),
                              SizedBox(width: 7),
                              DropdownButton<String>(
                                key: Key('BranchName'),
                                dropdownColor: Colors.white,
                                value: controllers[5].text,
                                iconEnabledColor: Colors.deepPurple.shade500,
                                style: TextStyle(
                                    color: Colors.deepPurple.shade500,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                items: branches.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    controllers[5].text = newValue!;
                                    if (controllers[5].text ==
                                        ' Select Branch                                                                                  ') {
                                      error[5] = 'Branch not selected';
                                    } else {
                                      error[5] = '';
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        error[5] == 'Branch not selected'
                            ? Container(
                                width: 575,
                                height: 29,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Branch Selection is Mandatory',
                                  style: TextStyle(
                                      color: Colors.red[700], fontSize: 12),
                                  textAlign: TextAlign.start,
                                ))
                            : SizedBox(height: 29),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GFButton(
                          onPressed: () async {
                            valid = true;
                            setState(() {
                              isLoading = true;
                              for (int i = 0; i < 6; i++) {
                                if (controllers[i].text == '') {
                                  error[i] = 'empty';
                                }
                              }
                              for (int i = 0; i < 6; i++) {
                                if (controllers[i].text == '' ||
                                    error[i] != '') {
                                  valid = false;
                                }
                              }
                              if (controllers[5].text ==
                                  ' Select Branch                                                                                  ') {
                                valid = false;
                                error[5] = 'Branch not selected';
                              }
                              if (gender == '' || gender == 'a') {
                                valid = false;
                                gender = '';
                              }
                            });
                            for (int i = 0;
                                i < ManagerState.maindata.length;
                                i++) {
                              if (controllers[1].text ==
                                  ManagerState.maindata[i]['Username']) {
                                error[1] = 'already exist';
                                valid = false;
                                break;
                              }
                            }
                            if (valid) {
                              Map<String, dynamic> query = {
                                'Username': controllers[1].text,
                                'EmailId': controllers[3].text,
                                'Password': controllers[1].text
                              };
                              await DB.openCon('managerlogin');
                              await DB.collection.insertOne(query);
                              await DB.closeCon();
                              query = {
                                'Name': controllers[0].text,
                                'Username': controllers[1].text,
                                'Phone': controllers[2].text,
                                'EmailId': controllers[3].text,
                                'Gender': gender,
                                'DateofBirth': controllers[4].text,
                                'Age': age,
                                'BranchName': controllers[5].text,
                                'Added By': LoginState.manager
                              };
                              await DB.openCon('managerinfo');
                              await DB.collection.insertOne(query);
                              await DB.closeCon();
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          text: 'Confirm',
                          key: Key('Add'),
                          textColor: Colors.white,
                          color: Colors.deepPurple.shade700,
                          hoverColor: Colors.deepPurple.shade500,
                          shape: GFButtonShape.square,
                          size: GFSize.LARGE,
                        ),
                        SizedBox(width: 200),
                        GFButton(
                          onPressed: () {
                            setState(() {
                              controllers[0].clear();
                              controllers[1].clear();
                              controllers[2].clear();
                              controllers[3].clear();
                              gender = '';
                              controllers[4].clear();
                              controllers[5].text =
                                  ' Select Branch                                                                                  ';
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          text: 'Clear',
                          textColor: Colors.white,
                          color: Colors.deepPurple.shade700,
                          hoverColor: Colors.deepPurple.shade500,
                          shape: GFButtonShape.square,
                          size: GFSize.LARGE,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
