// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/DataAddition/addmanager.dart';
import 'package:sadms/DataUpdation/updatemanager.dart';
import 'package:sadms/Database/database.dart';

class Manager extends StatefulWidget {
  Manager({Key? key}) : super(key: key);

  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  List<Map<String, dynamic>> data = [];
  var text = TextEditingController();
  int selectedvalue = 1;
  int selectedBox = -1;
  List<String> name = [];
  List<String> managername = [];
  List<String> gender = [];
  List<String> dob = [];
  List<int> age = [];
  List<String> phone = [];
  List<String> emailid = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Manager',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sort By:",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 30),
            DropdownButton(
                dropdownColor: Colors.deepPurple[600],
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
                value: selectedvalue,
                items: [
                  DropdownMenuItem(
                    value: 1,
                    alignment: Alignment.center,
                    child: Text('--Select Type--'),
                  ),
                  DropdownMenuItem(
                      value: 2,
                      alignment: Alignment.center,
                      child: Text('Name')),
                  DropdownMenuItem(
                      value: 3,
                      alignment: Alignment.center,
                      child: Text('ManagerName')),
                ],
                onChanged: (value) async {
                  name.clear();
                  managername.clear();
                  gender.clear();
                  dob.clear();
                  age.clear();
                  phone.clear();
                  emailid.clear();
                  selectedBox = -1;
                  if (value == 2) {
                    await DB.openCon('managerinfo');
                    data = await DB.collection.find().toList();
                    await DB.closeCon();
                    data.sort((a, b) => a["Name"].compareTo(b["Name"]));
                    setState(() {
                      selectedvalue = value!;
                      name.clear();
                      for (int i = 0; i < data.length; i++) {
                        name.add(data[i]['Name']);
                        managername.add(data[i]['ManagerName']);
                        gender.add(data[i]['Gender']);
                        dob.add(data[i]['DateofBirth'].toString());
                        age.add(data[i]['Age']);
                        phone.add(data[i]['Phone']);
                        emailid.add(data[i]['EmailId']);
                      }
                    });
                  } else if (value == 3) {
                    await DB.openCon('managerinfo');
                    data = await DB.collection.find().toList();
                    await DB.closeCon();
                    data.sort((a, b) => a["Name"].compareTo(b["Name"]));
                    setState(() {
                      selectedvalue = value!;
                      name.clear();
                      for (int i = 0; i < data.length; i++) {
                        name.add(data[i]['Name']);
                        managername.add(data[i]['ManagerName']);
                        gender.add(data[i]['Gender']);
                        dob.add(data[i]['DateofBirth'].toString());
                        age.add(data[i]['Age']);
                        phone.add(data[i]['Phone']);
                        emailid.add(data[i]['EmailId']);
                      }
                    });
                  } else {
                    setState(() {
                      selectedvalue = value!;
                    });
                  }
                }),
          ],
        ),
        SizedBox(height: 50),
        selectedvalue == 2
            ? SizedBox(
                width: 750,
                child: TextField(
                  controller: text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '@Managers Name',
                    labelText: 'Name',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
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
                  onChanged: (value) {
                    setState(() {
                      name.clear();
                      managername.clear();
                      gender.clear();
                      dob.clear();
                      age.clear();
                      phone.clear();
                      emailid.clear();
                      for (int i = 0; i < data.length; i++) {
                        if (value.length <= data[i]['Name'].length) {
                          String namestring = '';
                          for (int j = 0; j < value.length; j++) {
                            namestring = namestring + data[i]['Name'][j];
                          }
                          if (value.toLowerCase() == namestring.toLowerCase()) {
                            name.add(data[i]['Name']);
                            managername.add(data[i]['ManagerName']);
                            gender.add(data[i]['Gender']);
                            dob.add(data[i]['DateofBirth'].toString());
                            age.add(data[i]['Age']);
                            phone.add(data[i]['Phone']);
                            emailid.add(data[i]['EmailId']);
                          }
                        }
                      }
                    });
                  },
                ),
              )
            : selectedvalue == 3
                ? SizedBox(
                    width: 750,
                    child: TextField(
                      controller: text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '@ThereYouCome',
                        labelText: 'ManagerName',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
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
                      onChanged: (value) {
                        setState(() {
                          name.clear();
                          managername.clear();
                          gender.clear();
                          dob.clear();
                          age.clear();
                          phone.clear();
                          emailid.clear();
                          for (int i = 0; i < data.length; i++) {
                            if (value.length <= data[i]['ManagerName'].length) {
                              String namestring = '';
                              for (int j = 0; j < value.length; j++) {
                                namestring =
                                    namestring + data[i]['ManagerName'][j];
                              }
                              if (value.toLowerCase() ==
                                  namestring.toLowerCase()) {
                                name.add(data[i]['Name']);
                                managername.add(data[i]['ManagerName']);
                                gender.add(data[i]['Gender']);
                                dob.add(data[i]['DateofBirth'].toString());
                                age.add(data[i]['Age']);
                                phone.add(data[i]['Phone']);
                                emailid.add(data[i]['EmailId']);
                              }
                            }
                          }
                        });
                      },
                    ),
                  )
                : SizedBox(),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GFButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddManager())));
              },
              icon: Icon(
                Icons.add,
                color: Colors.green,
              ),
              text: 'Add',
              textColor: Colors.white,
              color: Colors.deepPurple.shade700,
              hoverColor: Colors.deepPurple.shade500,
              shape: GFButtonShape.square,
              size: GFSize.LARGE,
            ),
            SizedBox(width: 75),
            GFButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => UpdateManager())));
              },
              icon: Icon(
                Icons.update,
                color: Colors.blue,
              ),
              text: 'Update',
              textColor: Colors.white,
              color: Colors.deepPurple.shade700,
              hoverColor: Colors.deepPurple.shade500,
              shape: GFButtonShape.square,
              size: GFSize.LARGE,
            ),
            SizedBox(width: 75),
            GFButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              text: 'Delete',
              textColor: Colors.white,
              color: Colors.deepPurple.shade700,
              hoverColor: Colors.deepPurple.shade500,
              shape: GFButtonShape.square,
              size: GFSize.LARGE,
            ),
          ],
        ),
        SizedBox(height: 50),
        selectedvalue == 2
            ? Expanded(
                child: ListView.builder(
                  itemCount: name.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBox = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: selectedBox == index
                              ? Colors.deepPurple[900]
                              : Colors.deepPurple[700],
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Name: ${name[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'ManagerName: ${managername[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'EmailId: ${emailid[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Phone: ${phone[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'DOB: ${dob[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Age: ${age[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Gender: ${gender[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : selectedvalue == 3
                ? Expanded(
                    child: ListView.builder(
                        itemCount: managername.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedBox = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: selectedBox == index
                                    ? Colors.deepPurple[900]
                                    : Colors.deepPurple[700],
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'ManagerName: ${managername[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Name: ${name[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'EmailId: ${emailid[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Phone: ${phone[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'DOB: ${dob[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Age: ${age[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Gender: ${gender[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))
                : SizedBox(),
      ],
    );
  }
}
