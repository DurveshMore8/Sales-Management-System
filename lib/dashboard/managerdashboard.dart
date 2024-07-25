// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_local_variable

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
// import 'package:sales_management_system/Dashboard/report.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Login/login.dart';

class ManagerDashboard extends StatefulWidget {
  ManagerDashboard({Key? key}) : super(key: key);

  @override
  ManagerDashboardState createState() => ManagerDashboardState();
}

class ManagerDashboardState extends State<ManagerDashboard> {
  bool isLoading = false;
  int selectedValue = 1;
  static int year = 2023;
  Map<String, dynamic> manager = {};
  List<Map<String, dynamic>> employee = [];
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> branch = [];
  List<Map<String, dynamic>> customer = [];

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await DB.openCon('managerinfo');
    var data =
        await DB.collection.find({'Username': LoginState.manager}).toList();
    await DB.closeCon();
    manager = data[0];
    await DB.openCon('sales');
    List<Map<String, dynamic>> sales = await DB.collection.find().toList();
    await DB.closeCon();
    await DB.openCon('productsales');
    List<Map<String, dynamic>> products = await DB.collection.find().toList();
    await DB.closeCon();

    // Customer Sort
    if (manager['BranchName'] != '') {
      for (int i = 0; i < sales.length; i++) {
        int difference =
            DateTime.now().difference(DateTime.parse(sales[i]['Date'])).inDays;
        if (difference == 0 &&
            manager['BranchName'] == sales[i]['BranchName']) {
          customer.add(sales[i]);
        }
      }
    }

    customer.sort((a, b) => b['TotalPrice'].compareTo(a['TotalPrice']));
    if (customer.length > 5) {
      customer.removeRange(5, customer.length);
    }

    // Employee Sort
    await DB.openCon('employeelogin');
    List<Map<String, dynamic>> e = await DB.collection.find().toList();
    await DB.closeCon();
    for (int i = 0; i < e.length; i++) {
      employee.add({'Username': e[i]['Username'], 'Quantity': 0, 'Price': 0});
    }
    for (int i = 0; i < employee.length; i++) {
      for (int j = 0; j < sales.length; j++) {
        int differnce =
            DateTime.now().difference(DateTime.parse(sales[j]['Date'])).inDays;
        if (employee[i]['Username'] == sales[j]['SaleBy'] && differnce == 0) {
          employee[i]['Quantity'] += sales[j]['TotalQuantity'];
          employee[i]['Price'] += sales[j]['TotalPrice'];
        }
      }
    }

    // remove employees with no sale
    for (int i = employee.length - 1; i >= 0; i--) {
      if (employee[i]['Quantity'] == 0 || employee[i]['Price'] == 0) {
        employee.removeAt(i);
      }
    }

    employee.sort((a, b) => b['Price'].compareTo(a['Price']));
    if (employee.length > 5) {
      employee.removeRange(5, employee.length);
    }

    //Product Sort
    await DB.openCon('product');
    List<Map<String, dynamic>> p = await DB.collection.find().toList();
    await DB.closeCon();
    for (int i = 0; i < p.length; i++) {
      product
          .add({'ProductName': p[i]['ProductName'], 'Quantity': 0, 'Price': 0});
    }
    for (int i = 0; i < product.length; i++) {
      for (int j = 0; j < products.length; j++) {
        int differnce = DateTime.now()
            .difference(DateTime.parse(products[j]['Date']))
            .inDays;
        if (product[i]['ProductName'] == products[j]['ProductName'] &&
            products[j]['Quantity'] != 0 &&
            differnce == 0) {
          product[i]['Quantity'] += int.parse(products[j]['Quantity']);
          product[i]['Price'] += int.parse(products[j]['Price']);
        }
      }
    }

    // remove products with no sale
    for (int i = product.length - 1; i >= 0; i--) {
      if (product[i]['Quantity'] == 0 || product[i]['Price'] == 0) {
        product.removeAt(i);
      }
    }

    product.sort((a, b) => b['Price'].compareTo(a['Price']));
    if (product.length > 5) {
      product.removeRange(5, product.length);
    }

    //Branch Sort
    await DB.openCon('branch');
    List<Map<String, dynamic>> b = await DB.collection.find().toList();
    await DB.closeCon();
    for (int i = 0; i < b.length; i++) {
      branch.add({'BranchName': b[i]['BranchName'], 'Quantity': 0, 'Price': 0});
    }
    for (int i = 0; i < branch.length; i++) {
      for (int j = 0; j < sales.length; j++) {
        int differnce =
            DateTime.now().difference(DateTime.parse(sales[j]['Date'])).inDays;
        if (branch[i]['BranchName'] == sales[j]['BranchName'] &&
            differnce == 0) {
          branch[i]['Quantity'] += sales[j]['TotalQuantity'];
          branch[i]['Price'] += sales[j]['TotalPrice'];
        }
      }
    }

    // remove branchs with no sale
    for (int i = branch.length - 1; i >= 0; i--) {
      if (branch[i]['Quantity'] == 0 || branch[i]['Price'] == 0) {
        branch.removeAt(i);
      }
    }

    branch.sort(((a, b) => b['Price'].compareTo(a['Price'])));
    if (branch.length > 5) {
      branch.removeRange(5, branch.length);
    }

    setState(() {
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
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Dashboard',
                    key: Key('Title_Dashboard'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Row(
                      children: [
                        SizedBox(width: 50),
                        Text(
                          'Hello, ${manager['Name']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 179,
                    width: MediaQuery.of(context).size.width - 60,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                          color: Colors.deepPurple.shade800,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                        color: Colors.deepPurple.shade400,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                950,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                530,
                                        child: manager['BranchName'] == ''
                                            ? Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Container(
                                                  color: Colors
                                                      .deepPurple.shade400,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Download Sales Report till Now',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      GFButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          // await Reports
                                                          //     .generateReport();
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        },
                                                        text:
                                                            'Generate Reports',
                                                        color: Colors.deepPurple
                                                            .shade800,
                                                        shape: GFButtonShape
                                                            .square,
                                                        size: GFSize.LARGE,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            : customer.isEmpty
                                                ? Center(
                                                    child: Text(
                                                      'No Customers found',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    itemCount:
                                                        customer.length < 5
                                                            ? customer.length
                                                            : 5,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Container(
                                                            color: Colors
                                                                .deepPurple
                                                                .shade800,
                                                            height: 40,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  'Customer Name: ${customer[index]['CustomerName']}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Quantity: ${customer[index]['TotalQuantity']}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Price: ${customer[index]['TotalPrice']}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ));
                                                    },
                                                  ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        color: Colors.deepPurple.shade400,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                950,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                530,
                                        child: employee.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'No Employees found',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: employee.length < 5
                                                    ? employee.length
                                                    : 5,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Container(
                                                        color: Colors.deepPurple
                                                            .shade800,
                                                        height: 40,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              'Username: ${employee[index]['Username']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Quantity: ${employee[index]['Quantity']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Price: ${employee[index]['Price']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                },
                                              )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        color: Colors.deepPurple.shade400,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                950,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                530,
                                        child: product.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'No Product found',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: product.length < 5
                                                    ? product.length
                                                    : 5,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Container(
                                                        color: Colors.deepPurple
                                                            .shade800,
                                                        height: 40,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              'ProductName: ${product[index]['ProductName']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Quantity: ${product[index]['Quantity']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Price: ${product[index]['Price']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                },
                                              )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        color: Colors.deepPurple.shade400,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                950,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                530,
                                        child: branch.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'No Branch found',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: branch.length < 5
                                                    ? branch.length
                                                    : 5,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Container(
                                                        color: Colors.deepPurple
                                                            .shade800,
                                                        height: 40,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              'BranchName: ${branch[index]['BranchName']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Quantity: ${branch[index]['Quantity']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Price: ${branch[index]['Price']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                },
                                              )),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ));
  }
}
