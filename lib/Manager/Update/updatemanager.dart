// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'package:age_calculator/age_calculator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Login/login.dart';
import 'package:sadms/Manager/manager.dart';

class UpdateManager extends StatefulWidget {
  UpdateManager({Key? key}) : super(key: key);

  @override
  _UpdateManagerState createState() => _UpdateManagerState();
}

class _UpdateManagerState extends State<UpdateManager> {
  //name, username, phone, emailid, dob, branchname
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<String> error = ['', '', '', '', '', ''];
  int age = -1;
  String gender = 'a';
  bool valid = true;

  @override
  void initState() {
    super.initState();
    controllers[0].text = ManagerState.updateManager['Name'];
    controllers[1].text = ManagerState.updateManager['Username'];
    controllers[2].text = ManagerState.updateManager['Phone'];
    controllers[3].text = ManagerState.updateManager['EmailId'];
    gender = ManagerState.updateManager['Gender'];
    controllers[4].text = ManagerState.updateManager['DateofBirth'];
    age = AgeCalculator.age(DateTime.parse(controllers[4].text)).years;
    controllers[5].text = ManagerState.updateManager['BranchName'];
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
                  'Update Manager',
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
                error[0] == '' ? SizedBox(height: 34) : SizedBox(height: 10),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: controllers[1],
                    readOnly: true,
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
                error[1] == '' ? SizedBox(height: 34) : SizedBox(height: 10),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: controllers[2],
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
                      prefixIcon:
                          Icon(Icons.phone, color: Colors.deepPurple.shade500),
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
                error[2] == '' ? SizedBox(height: 34) : SizedBox(height: 10),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: controllers[3],
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
                      prefixIcon:
                          Icon(Icons.email, color: Colors.deepPurple.shade500),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (EmailValidator.validate(controllers[3].text)) {
                          error[3] = '';
                        } else {
                          error[3] = 'invalid';
                        }
                      });
                    },
                  ),
                ),
                error[3] == '' ? SizedBox(height: 34) : SizedBox(height: 10),
                SizedBox(
                  width: 600,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        SizedBox(
                            child: Icon(Icons.person,
                                color: Colors.deepPurple[500])),
                        SizedBox(width: 10),
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
                              groupValue: gender,
                              activeBgColor: Colors.white,
                              radioColor: Colors.deepPurple.shade500,
                              activeBorderColor: Colors.deepPurple.shade900,
                              inactiveBorderColor: Colors.deepPurple.shade900,
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
                              groupValue: gender,
                              activeBgColor: Colors.white,
                              radioColor: Colors.deepPurple.shade500,
                              activeBorderColor: Colors.deepPurple.shade900,
                              inactiveBorderColor: Colors.deepPurple.shade900,
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
                        height: 34,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Gender Can\'t be unselected',
                          style:
                              TextStyle(color: Colors.red[700], fontSize: 12),
                          textAlign: TextAlign.start,
                        ))
                    : SizedBox(height: 34),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: controllers[4],
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
                      errorText:
                          error[4] == 'empty' ? 'Date Can\'t be empty' : null,
                      prefixIcon: Icon(Icons.date_range,
                          color: Colors.deepPurple.shade500),
                      prefixIconColor: Colors.deepPurple.shade500,
                      suffixIcon: IconButton(
                          icon: Icon(Icons.edit_calendar),
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
                              age = AgeCalculator.age(selectedDate!).years;
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
                error[4] == '' ? SizedBox(height: 34) : SizedBox(height: 10),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: controllers[5],
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Naupada Branch',
                      labelText: 'Branch Name',
                      labelStyle: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepPurple.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      errorText: error[5] == 'empty'
                          ? 'Branch Name Can\'t be empty'
                          : error[5] == 'invalid'
                              ? 'Invalid Branch Name'
                              : null,
                      prefixIcon:
                          Icon(Icons.store, color: Colors.deepPurple.shade500),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.length < 8 || value.length > 20) {
                          error[5] = 'invalid';
                        } else {
                          error[5] = '';
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            error[5] == '' ? SizedBox(height: 30) : SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFButton(
                  onPressed: () async {
                    valid = true;
                    setState(() {
                      for (int i = 0; i < 6; i++) {
                        if (controllers[i].text == '') {
                          error[i] = 'empty';
                        }
                      }
                      for (int i = 0; i < 6; i++) {
                        if (controllers[i].text == '' || error[i] != '') {
                          valid = false;
                        }
                      }
                      if (gender == '' || gender == 'a') {
                        valid = false;
                        gender = '';
                      }
                    });
                    if (valid) {
                      await DB.openCon('managerlogin');
                      await DB.updatedata('Username', controllers[1].text,
                          'EmailId', controllers[3].text);
                      await DB.closeCon();
                      await DB.openCon('managerinfo');
                      await DB.updatedata('Username', controllers[1].text,
                          'Name', controllers[0].text);
                      await DB.updatedata('Username', controllers[1].text,
                          'Phone', controllers[2].text);
                      await DB.updatedata('Username', controllers[1].text,
                          'EmailId', controllers[3].text);
                      await DB.updatedata(
                          'Username', controllers[1].text, 'Gender', gender);
                      await DB.updatedata('Username', controllers[1].text,
                          'DateofBirth', controllers[4].text);
                      await DB.updatedata(
                          'Username', controllers[1].text, 'Age', age);
                      await DB.updatedata('Username', controllers[1].text,
                          'BranchName', controllers[5].text);
                      await DB.updatedata('Username', controllers[1].text,
                          'UpdatedBy', LoginState());
                      await DB.closeCon();
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  text: 'Confirm',
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
                      controllers[5].clear();
                    });
                  },
                  icon: Icon(
                    Icons.clear,
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
    );
  }
}
