// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Login/login.dart';
import 'package:sales_management_system/Manager/Add/addstock.dart';

class Stock extends StatefulWidget {
  Stock({Key? key}) : super(key: key);

  @override
  StockState createState() => StockState();
}

class StockState extends State<Stock> {
  List<Map<String, dynamic>> maindata = [];
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> branch = [];
  static Map<String, dynamic> addStock = {};
  var text = TextEditingController();
  int selectedBox = -1;
  List<String> productid = [];
  List<String> productname = [];
  List<String> branchname = [];
  List<int> quantity = [];
  bool check = false;
  bool isLoading = true;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    productid.clear();
    productname.clear();
    branchname.clear();
    quantity.clear();
    selectedBox = -1;
    await DB.openCon('managerinfo');
    branch =
        await DB.collection.find({'Username': LoginState.manager}).toList();
    await DB.closeCon();
    await DB.openCon('stock');
    maindata = await DB.collection.find().toList();
    data = await DB.collection.find().toList();
    await DB.closeCon();
    maindata.sort((a, b) => a["ProductName"].compareTo(b["ProductName"]));
    setState(() {
      for (int i = 0; i < maindata.length; i++) {
        productid.add(maindata[i]['ProductId']);
        productname.add(maindata[i]['ProductName']);
        branchname.add(maindata[i]['BranchName']);
        quantity.add(maindata[i]['Quantity']);
      }
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
                    'Stock',
                    key: Key('Title_Stock'),
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
                        hintText: 'Tata Nano',
                        labelText: 'Product Name',
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
                          if (check) {
                            data.clear();
                            if (value == '') {
                              data.addAll(maindata);
                            } else {
                              for (int i = 0; i < maindata.length; i++) {
                                if (value.length <=
                                    maindata[i]['ProductName'].length) {
                                  String productnamestring = '';
                                  for (int j = 0; j < value.length; j++) {
                                    productnamestring = productnamestring +
                                        maindata[i]['ProductName'][j];
                                  }
                                  if (value.toLowerCase() ==
                                          productnamestring.toLowerCase() &&
                                      maindata[i]['BranchName'] ==
                                          branch[0]['BranchName']) {
                                    data.add(maindata[i]);
                                  }
                                }
                              }
                            }
                          } else {
                            data.clear();
                            if (value == '') {
                              data.addAll(maindata);
                            } else {
                              for (int i = 0; i < maindata.length; i++) {
                                if (value.length <=
                                    maindata[i]['ProductName'].length) {
                                  String productnamestring = '';
                                  for (int j = 0; j < value.length; j++) {
                                    productnamestring = productnamestring +
                                        maindata[i]['ProductName'][j];
                                  }
                                  if (value.toLowerCase() ==
                                      productnamestring.toLowerCase()) {
                                    data.add(maindata[i]);
                                  }
                                }
                              }
                            }
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GFButton(
                        onPressed: () async {
                          if (selectedBox > -1) {
                            addStock = data[selectedBox];
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => AddStock())))
                                .whenComplete(() {
                              getData();
                              setState(() {
                                check = false;
                                text.clear();
                              });
                            });
                          }
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        text: 'Add Stock',
                        key: Key('Add'),
                        textColor: Colors.white,
                        color: Colors.deepPurple.shade700,
                        hoverColor: Colors.deepPurple.shade500,
                        shape: GFButtonShape.square,
                        size: GFSize.LARGE,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  // SizedBox(
                  //   child: ListTile(
                  //     title: Text('Display Stock of My Branch',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //         )),
                  //     leading: GFCheckbox(
                  //       key: Key('Check'),
                  //       value: check,
                  //       size: 25,
                  //       activeBgColor: Colors.deepPurple.shade700,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           selectedBox = -1;
                  //           check = value;
                  //           data.clear();
                  //           if (check) {
                  //             for (int i = 0; i < maindata.length; i++) {
                  //               if (maindata[i]['BranchName'] ==
                  //                   branch[0]['BranchName']) {
                  //                 data.add(maindata[i]);
                  //               }
                  //             }
                  //           } else {
                  //             data.addAll(maindata);
                  //           }
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.isEmpty ? 1 : data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (data[index]['BranchName'] ==
                                    branch[0]['BranchName'] ||
                                branch[0]['BranchName'] == '') {
                              setState(() {
                                selectedBox = index;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: data.isEmpty
                                ? Center(
                                    child: Text(
                                      'No Stock Available',
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
                                              'Product Name: ${data[index]['ProductName']}',
                                              key: Key('ProductName'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Product Id: ${data[index]['ProductId']}',
                                              key: Key('ProductId'),
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
                                              'Branch Name: ${data[index]['BranchName']}',
                                              key: Key('BranchName'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Quantity: ${data[index]['Quantity']}',
                                              key: Key('Quantity'),
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
