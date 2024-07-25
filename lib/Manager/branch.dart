// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Manager/Add/addbranch.dart';
import 'package:sales_management_system/Manager/Update/updatebranch.dart';

class Branch extends StatefulWidget {
  Branch({Key? key}) : super(key: key);

  @override
  BranchState createState() => BranchState();
}

class BranchState extends State<Branch> {
  static List<Map<String, dynamic>> maindata = [];
  List<Map<String, dynamic>> data = [];
  static Map<String, dynamic> updateBranch = {};
  var text = TextEditingController();
  int selectedBox = -1;
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    data.clear();
    await DB.openCon('branch');
    maindata = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      data.addAll(maindata);
      maindata.sort((a, b) => a['BranchName'].compareTo(b['BranchName']));
      data.sort((a, b) => a['BranchName'].compareTo(b['BranchName']));
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
                    'Branch',
                    key: Key('Title_Branch'),
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
                      key: Key('Search'),
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
                        prefixIcon: Icon(
                          Icons.text_format_outlined,
                          color: Colors.deepPurple.shade500,
                        ),
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
                                  maindata[i]['BranchName'].length) {
                                String branchnamestring = '';
                                for (int j = 0; j < value.length; j++) {
                                  branchnamestring = branchnamestring +
                                      maindata[i]['BranchName'][j];
                                }
                                if (value.toLowerCase() ==
                                    branchnamestring.toLowerCase()) {
                                  data.add(maindata[i]);
                                }
                              }
                            }
                          }
                          selectedBox = -1;
                        });
                      },
                    ),
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
                                      builder: ((context) => AddBranch())))
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
                        key: Key('Add'),
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
                                        builder: ((context) => UpdateBranch())))
                                .whenComplete(() {
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
                        key: Key('Update'),
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
                            await DB.openCon('branch');
                            await DB.collection.remove(
                                {'BranchId': data[selectedBox]['BranchId']});
                            await DB.closeCon();
                            await DB.openCon('stock');
                            await DB.collection.remove({
                              'BranchName': data[selectedBox]['BranchName']
                            });
                            await DB.closeCon();
                            selectedBox = -1;
                            setState(() {
                              getData();
                              isLoading = false;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        text: 'Delete',
                        key: Key('Delete'),
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
                      itemCount: data.isEmpty ? 1 : data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBox = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: data.isEmpty
                                ? Center(
                                    child: Text(
                                      'No Branch Available',
                                      key: Key('Message'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Container(
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
                                              'Branch Name: ${data[index]['BranchName']}',
                                              key: Key('BranchName'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Location: ${data[index]['Location']}',
                                              key: Key('Location'),
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
                                              'Branch Id: ${data[index]['BranchId']}',
                                              key: Key('BranchId'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'City: ${data[index]['City']}',
                                              key: Key('City'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'State: ${data[index]['State']}',
                                              key: Key('State'),
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
              ));
  }
}
