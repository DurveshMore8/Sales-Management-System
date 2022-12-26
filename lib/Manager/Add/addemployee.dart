// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({Key? key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  var name = TextEditingController();
  var username = TextEditingController();
  var phone = TextEditingController();
  var emailid = TextEditingController();
  var dob = TextEditingController();
  int age = -1;
  String gender = '';

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
                  'Add Employee',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Column(
              children: [
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: name,
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
                      prefixIcon: Icon(Icons.text_format_outlined),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: username,
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
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: phone,
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
                      prefixIcon: Icon(Icons.phone),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: emailid,
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
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: dob,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'YYYY-MM-DD',
                      labelText: 'Date',
                      labelStyle: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepPurple.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      prefixIcon: Icon(Icons.date_range),
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
                              age = AgeCalculator.age(selectedDate!).years;
                              List<String> date =
                                  selectedDate.toString().split('');
                              dob.clear();
                              for (int i = 0; i < 10; i++) {
                                dob.text += date[i];
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
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFButton(
                  onPressed: () async {
                    Map<String, dynamic> query = {
                      'Username': username.text,
                      'Password': username.text
                    };
                    await DB.openCon('employeelogin');
                    await DB.collection.insertOne(query);
                    await DB.closeCon();
                    query = {
                      'Name': name.text,
                      'Username': username.text,
                      'Phone': phone.text,
                      'EmailId': emailid.text,
                      'Gender': gender,
                      'DateofBirth': dob.text,
                      'Age': age
                    };
                    await DB.openCon('employeeinfo');
                    await DB.collection.insertOne(query);
                    await DB.closeCon();
                    Navigator.pop(context);
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
                      name.clear();
                      username.clear();
                      phone.clear();
                      emailid.clear();
                      gender = '';
                      dob.clear();
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
    );
  }
}
