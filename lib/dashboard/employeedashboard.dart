// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Login/login.dart';

class EmployeeDashboard extends StatefulWidget {
  EmployeeDashboard({Key? key}) : super(key: key);

  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  bool isLoading = false;
  Map<String, dynamic> employee = {};
  List<Map<String, dynamic>> customer = [];
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> sale = [];

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await DB.openCon('employeeinfo');
    var data =
        await DB.collection.find({'Username': LoginState.employee}).toList();
    await DB.closeCon();
    employee = data[0];
    await DB.openCon('sales');
    List<Map<String, dynamic>> sales = await DB.collection.find().toList();
    await DB.closeCon();
    await DB.openCon('productsales');
    List<Map<String, dynamic>> products = await DB.collection.find().toList();
    await DB.closeCon();

    // Sales Sort
    for (int i = 0; i < sales.length; i++) {
      if (DateTime.now().difference(DateTime.parse(sales[i]['Date'])).inDays ==
              0 &&
          sales[i]['BranchName'] == employee['BranchName']) {
        sale.add(sales[i]);
      }
    }

    // Customer Sort
    for (int i = 0; i < sales.length; i++) {
      int difference =
          DateTime.now().difference(DateTime.parse(sales[i]['Date'])).inDays;
      if (difference == 0 && employee['BranchName'] == sales[i]['BranchName']) {
        customer.add(sales[i]);
      }
    }
    customer.sort((a, b) => b['TotalPrice'].compareTo(a['TotalPrice']));
    if (customer.length > 5) {
      customer.removeRange(5, customer.length);
    }

    // Product Sort
    await DB.openCon('product');
    List<Map<String, dynamic>> p = await DB.collection.find().toList();
    await DB.closeCon();
    await DB.openCon('sales');
    List<Map<String, dynamic>> s =
        await DB.collection.find({'SaleBy': LoginState.employee}).toList();
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
        for (int k = 0; k < s.length; k++) {
          if (product[i]['ProductName'] == products[j]['ProductName'] &&
              products[j]['Quantity'] != 0 &&
              products[j]['OrderId'] == s[k]['_id'] &&
              differnce == 0) {
            product[i]['Quantity'] += int.parse(products[j]['Quantity']);
            product[i]['Price'] += int.parse(products[j]['Price']);
          }
        }
      }
    }
    product.sort((a, b) => b['Price'].compareTo(a['Price']));
    if (product.length > 5) {
      product.removeRange(5, product.length);
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          'Hello, ${employee['Name']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                        color: Colors.deepPurple.shade800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      color: Colors.deepPurple.shade400,
                                      width: 600,
                                      height: 250,
                                      child: ListView.builder(
                                        itemCount: customer.length < 5
                                            ? customer.length
                                            : 5,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Container(
                                                color:
                                                    Colors.deepPurple.shade800,
                                                height: 40,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Customer Name: ${customer[index]['CustomerName']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Quantity: ${customer[index]['TotalQuantity']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Price: ${customer[index]['TotalPrice']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        },
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.all(5),
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
                                                color:
                                                    Colors.deepPurple.shade800,
                                                height: 40,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Product Name: ${product[index]['ProductName']}',
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
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(23, 10, 23, 0),
                              child: Container(
                                  color: Colors.deepPurple.shade400,
                                  height: 250,
                                  child: ListView.builder(
                                    itemCount:
                                        sale.length < 5 ? sale.length : 5,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            color: Colors.deepPurple.shade800,
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Customer Name: ${sale[index]['CustomerName']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Phone: ${sale[index]['Phone']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    Text(
                                                      'EmailId: ${sale[index]['EmailId']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Price: ${sale[index]['TotalPrice']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Quantity: ${sale[index]['TotalQuantity']}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ));
                                    },
                                  )),
                            ),
                          ],
                        )),
                  )),
                ],
              ));
  }
}
