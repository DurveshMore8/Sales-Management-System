// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Login/login.dart';
import 'package:sadms/Manager/Add/addmanager.dart';
import 'package:sadms/Manager/Update/updatemanager.dart';
import 'package:sadms/Database/database.dart';

class Manager extends StatefulWidget {
  Manager({Key? key}) : super(key: key);

  @override
  ManagerState createState() => ManagerState();
}

class ManagerState extends State<Manager> {
  static List<Map<String, dynamic>> maindata = [];
  List<Map<String, dynamic>> data = [];
  static Map<String, dynamic> updateManager = {};
  var text = TextEditingController();
  int selectedBox = -1;
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    data.clear();
    await DB.openCon('managerinfo');
    maindata = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      data.addAll(maindata);
      maindata.sort((a, b) => a['Name'].compareTo(b['Name']));
      data.sort((a, b) => a['Name'].compareTo(b['Name']));
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
        backgroundColor: Colors.deepPurple.shade400,
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
            : Column(
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
                  SizedBox(
                    width: 750,
                    child: TextField(
                        controller: text,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Durvesh More',
                          labelText: 'Name',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
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
                        onChanged: (value) {
                          setState(() {
                            data.clear();
                            if (value == '') {
                              data.addAll(maindata);
                            } else {
                              for (int i = 0; i < maindata.length; i++) {
                                if (value.length <=
                                    maindata[i]['Name'].length) {
                                  String namestring = '';
                                  for (int j = 0; j < value.length; j++) {
                                    namestring =
                                        namestring + maindata[i]['Name'][j];
                                  }
                                  if (value.toLowerCase() ==
                                      namestring.toLowerCase()) {
                                    data.add(maindata[i]);
                                  }
                                }
                              }
                            }
                            selectedBox = -1;
                          });
                        }),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GFButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => AddManager())))
                              .whenComplete(() {
                            text.clear();
                            selectedBox = -1;
                            getData();
                          });
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
                          if (selectedBox > -1) {
                            updateManager = data[selectedBox];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        UpdateManager()))).whenComplete(() {
                              text.clear();
                              selectedBox = -1;
                              getData();
                            });
                          }
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
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (selectedBox > -1) {
                            await DB.openCon('managerinfo');
                            await DB.collection.remove(
                                {'Username': data[selectedBox]['Username']});
                            await DB.closeCon();
                            await DB.openCon('managerlogin');
                            await DB.collection.remove(
                                {'Username': data[selectedBox]['Username']});
                            await DB.closeCon();
                            selectedBox = -1;
                            getData();
                          }
                        },
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (data[index]['Username'] ==
                                      LoginState.manager ||
                                  data[index]['BranchName'] == '') {
                                selectedBox = -1;
                              } else {
                                selectedBox = index;
                              }
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
                                        'Name: ${data[index]['Name']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'Username: ${data[index]['Username']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'EmailId: ${data[index]['EmailId']}',
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
                                        'Phone: ${data[index]['Phone']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'DOB: ${data[index]['DateofBirth']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'Age: ${data[index]['Age']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'Gender: ${data[index]['Gender']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      data[index]['BranchName'] == ''
                                          ? Text('Branch Name: No Branch',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ))
                                          : Text(
                                              'Branch Name: ${data[index]['BranchName']}',
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
                ],
              ));
  }
}
