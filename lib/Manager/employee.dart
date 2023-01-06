// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Manager/Add/addemployee.dart';
import 'package:sadms/Manager/Update/updateemployee.dart';

class Employee extends StatefulWidget {
  Employee({Key? key}) : super(key: key);

  @override
  EmployeeState createState() => EmployeeState();
}

class EmployeeState extends State<Employee> {
  List<Map<String, dynamic>> maindata = [];
  List<Map<String, dynamic>> data = [];
  static Map<String, dynamic> updateEmployee = {};
  var text = TextEditingController();
  int selectedBox = -1;
  List<String> name = [];
  List<String> username = [];
  List<String> gender = [];
  List<String> dob = [];
  List<int> age = [];
  List<String> phone = [];
  List<String> emailid = [];

  void getData() async {
    name.clear();
    username.clear();
    gender.clear();
    dob.clear();
    age.clear();
    phone.clear();
    emailid.clear();
    await DB.openCon('employeeinfo');
    maindata = await DB.collection.find().toList();
    data = await DB.collection.find().toList();
    await DB.closeCon();
    maindata.sort((a, b) => a['Name'].compareTo(b['Name']));
    data.sort((a, b) => a['Name'].compareTo(b['Name']));
    setState(() {
      for (int i = 0; i < maindata.length; i++) {
        name.add(maindata[i]['Name']);
        username.add(maindata[i]['Username']);
        gender.add(maindata[i]['Gender']);
        dob.add(maindata[i]['DateofBirth']);
        age.add(maindata[i]['Age']);
        emailid.add(maindata[i]['EmailId']);
        phone.add(maindata[i]['Phone']);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Employee',
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
                prefixIcon: Icon(Icons.text_format_outlined),
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
                      if (value.length <= maindata[i]['Name'].length) {
                        String namestring = '';
                        for (int j = 0; j < value.length; j++) {
                          namestring = namestring + maindata[i]['Name'][j];
                        }
                        if (value.toLowerCase() == namestring.toLowerCase()) {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddEmployee())));
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
                  updateEmployee = data[selectedBox];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => UpdateEmployee())));
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
                if (selectedBox > -1) {
                  await DB.openCon('employeeinfo');
                  await DB.collection
                      .remove({'Username': data[selectedBox]['Username']});
                  await DB.closeCon();
                  await DB.openCon('employeelogin');
                  await DB.collection
                      .remove({'Username': data[selectedBox]['Username']});
                  await DB.closeCon();
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
