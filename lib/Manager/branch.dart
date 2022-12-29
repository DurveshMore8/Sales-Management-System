// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Manager/Add/addbranch.dart';
import 'package:sadms/Manager/Update/updatebranch.dart';

class Branch extends StatefulWidget {
  Branch({Key? key}) : super(key: key);

  @override
  BranchState createState() => BranchState();
}

class BranchState extends State<Branch> {
  List<Map<String, dynamic>> data = [];
  static Map<String, dynamic> updateBranch = {};
  var text = TextEditingController();
  int selectedvalue = 1;
  int selectedBox = -1;
  List<String> branchid = [];
  List<String> branchname = [];
  List<String> location = [];
  List<String> city = [];
  List<String> state = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Branch',
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
                      child: Text('Branch Name')),
                  DropdownMenuItem(
                      value: 3,
                      alignment: Alignment.center,
                      child: Text('Branch Id')),
                ],
                onChanged: (value) async {
                  branchid.clear();
                  branchname.clear();
                  location.clear();
                  city.clear();
                  state.clear();
                  selectedBox = -1;
                  if (value == 2) {
                    await DB.openCon('branch');
                    data = await DB.collection.find().toList();
                    await DB.closeCon();
                    data.sort(
                        (a, b) => a["BranchName"].compareTo(b["BranchName"]));
                    setState(() {
                      selectedvalue = value!;
                      branchname.clear();
                      for (int i = 0; i < data.length; i++) {
                        branchid.add(data[i]['BranchId']);
                        branchname.add(data[i]['BranchName']);
                        location.add(data[i]['Location']);
                        city.add(data[i]['City']);
                        state.add(data[i]['State']);
                      }
                    });
                  } else if (value == 3) {
                    await DB.openCon('branch');
                    data = await DB.collection.find().toList();
                    await DB.closeCon();
                    data.sort((a, b) => a["BranchId"].compareTo(b["BranchId"]));
                    setState(() {
                      selectedvalue = value!;
                      branchname.clear();
                      for (int i = 0; i < data.length; i++) {
                        branchid.add(data[i]['BranchId']);
                        branchname.add(data[i]['BranchName']);
                        location.add(data[i]['Location']);
                        city.add(data[i]['City']);
                        state.add(data[i]['State']);
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
                    hintText: 'Mahaveer Sales',
                    labelText: 'Branch Name',
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
                      branchid.clear();
                      branchname.clear();
                      location.clear();
                      city.clear();
                      state.clear();
                      for (int i = 0; i < data.length; i++) {
                        if (value.length <= data[i]['BranchName'].length) {
                          String branchnamestring = '';
                          for (int j = 0; j < value.length; j++) {
                            branchnamestring =
                                branchnamestring + data[i]['BranchName'][j];
                          }
                          if (value.toLowerCase() ==
                              branchnamestring.toLowerCase()) {
                            branchid.add(data[i]['BranchId']);
                            branchname.add(data[i]['BranchName']);
                            location.add(data[i]['Location']);
                            city.add(data[i]['City']);
                            state.add(data[i]['State']);
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
                        hintText: 'MahSales3429',
                        labelText: 'Branch Id',
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
                          branchid.clear();
                          branchname.clear();
                          location.clear();
                          city.clear();
                          state.clear();
                          for (int i = 0; i < data.length; i++) {
                            if (value.length <= data[i]['BranchId'].length) {
                              String branchidstring = '';
                              for (int j = 0; j < value.length; j++) {
                                branchidstring =
                                    branchidstring + data[i]['BranchId'][j];
                              }
                              if (value.toLowerCase() ==
                                  branchidstring.toLowerCase()) {
                                branchid.add(data[i]['BranchId']);
                                branchname.add(data[i]['BranchName']);
                                location.add(data[i]['Location']);
                                city.add(data[i]['City']);
                                state.add(data[i]['State']);
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
                    MaterialPageRoute(builder: ((context) => AddBranch())));
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
                  updateBranch = data[selectedBox];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => UpdateBranch())));
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
                  await DB.openCon('branch');
                  await DB.collection
                      .remove({'BranchId': data[selectedBox]['BranchId']});
                  await DB.closeCon();
                  setState(() {
                    selectedvalue = 1;
                  });
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
        selectedvalue == 2
            ? Expanded(
                child: ListView.builder(
                  itemCount: branchname.length,
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
                                    'Branch Name: ${branchname[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Location: ${location[index]}',
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
                                    'Branch Id: ${branchid[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'City: ${city[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'State: ${state[index]}',
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
                        itemCount: branchid.length,
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
                                          'Branch Id: ${branchid[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Location: ${location[index]}',
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
                                          'Branch Name: ${branchname[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'City: ${city[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'State: ${state[index]}',
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
