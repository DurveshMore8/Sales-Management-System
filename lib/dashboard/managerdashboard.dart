// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Login/login.dart';

class ManagerDashboard extends StatefulWidget {
  ManagerDashboard({Key? key}) : super(key: key);

  @override
  _ManagerDashboardState createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  bool isLoading = false;
  Map<String, dynamic> manager = {};
  List<Map<String, dynamic>> employee = [];
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> branch = [];

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

    // Employee Sort
    await DB.openCon('employeelogin');
    List<Map<String, dynamic>> e = await DB.collection.find().toList();
    await DB.closeCon();
    for (int i = 0; i < e.length; i++) {
      employee.add({'Username': e[i]['Username'], 'Quantity': 0, 'Price': 0});
    }
    for (int i = 0; i < employee.length; i++) {
      for (int j = 0; j < sales.length; j++) {
        if (employee[i]['Username'] == sales[j]['SaleBy']) {
          employee[i]['Quantity'] += sales[j]['TotalQuantity'];
          employee[i]['Price'] += sales[j]['TotalPrice'];
        }
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
        if (product[i]['ProductName'] == products[j]['ProductName'] &&
            products[j]['Quantity'] != 0) {
          product[i]['Quantity'] += int.parse(products[j]['Quantity']);
          product[i]['Price'] += int.parse(products[j]['Price']);
        }
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
        if (branch[i]['BranchName'] == sales[j]['BranchName']) {
          branch[i]['Quantity'] += sales[j]['TotalQuantity'];
          branch[i]['Price'] += sales[j]['TotalPrice'];
        }
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
                  Expanded(
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
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Colors.deepPurple.shade400,
                                        width: 600,
                                        height: 250,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        color: Colors.deepPurple.shade400,
                                        width: 600,
                                        height: 250,
                                        child: ListView.builder(
                                          itemCount: employee.length < 5
                                              ? employee.length
                                              : 5,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Container(
                                                  color: Colors
                                                      .deepPurple.shade800,
                                                  height: 40,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Username: ${employee[index]['Username']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Quantity: ${employee[index]['Quantity']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Price: ${employee[index]['Price']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
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
                                        width: 600,
                                        height: 250,
                                        child: ListView.builder(
                                          itemCount: product.length < 5
                                              ? product.length
                                              : 5,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Container(
                                                  color: Colors
                                                      .deepPurple.shade800,
                                                  height: 40,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'ProductName: ${product[index]['ProductName']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Quantity: ${product[index]['Quantity']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Price: ${product[index]['Price']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
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
                                        width: 600,
                                        height: 250,
                                        child: ListView.builder(
                                          itemCount: branch.length < 5
                                              ? branch.length
                                              : 5,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Container(
                                                  color: Colors
                                                      .deepPurple.shade800,
                                                  height: 40,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'BranchName: ${branch[index]['BranchName']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Quantity: ${branch[index]['Quantity']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Price: ${branch[index]['Price']}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
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
