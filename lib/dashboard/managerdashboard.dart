// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Login/login.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ManagerDashboard extends StatefulWidget {
  ManagerDashboard({Key? key}) : super(key: key);

  @override
  _ManagerDashboardState createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  bool isLoading = false;
  int selectedValue = 1;
  int year = 2023;
  Map<String, dynamic> manager = {};
  List<Map<String, dynamic>> employee = [];
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> branch = [];
  List<Map<String, dynamic>> customer = [];

  Future generateReport() async {
    const tableHeaders = ['Category', 'Budget', 'Expense', 'Result'];

    PdfPageFormat pageFormat = PdfPageFormat.a4;

    const dataTable = [
      ['Phone', 80, 95],
      ['Internet', 250, 230],
      ['Electricity', 300, 375],
      ['Movies', 85, 80],
      ['Food', 300, 350],
      ['Fuel', 650, 550],
      ['Insurance', 250, 310],
    ];

    // Some summary maths
    final budget = dataTable
        .map((e) => e[1] as num)
        .reduce((value, element) => value + element);
    final expense = dataTable
        .map((e) => e[2] as num)
        .reduce((value, element) => value + element);

    const baseColor = PdfColors.cyan;

    // Create a PDF document.
    final document = pw.Document();

    final theme = pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
    );

    // Title Page
    document.addPage(
      pw.Page(
          pageFormat: pageFormat,
          theme: theme,
          build: (context) {
            return pw.Center(
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                  pw.Text('Sales Report'),
                  pw.Text('$year'),
                ]));
          }),
    );

    // Top bar chart
    final chart1 = pw.Chart(
      left: pw.Container(
        alignment: pw.Alignment.topCenter,
        margin: const pw.EdgeInsets.only(right: 5, top: 10),
        child: pw.Transform.rotateBox(
          angle: pi / 2,
          child: pw.Text('Amount'),
        ),
      ),
      overlay: pw.ChartLegend(
        position: const pw.Alignment(-.7, 1),
        decoration: pw.BoxDecoration(
          color: PdfColors.white,
          border: pw.Border.all(
            color: PdfColors.black,
            width: .5,
          ),
        ),
      ),
      grid: pw.CartesianGrid(
        xAxis: pw.FixedAxis.fromStrings(
          List<String>.generate(
              dataTable.length, (index) => dataTable[index][0] as String),
          marginStart: 30,
          marginEnd: 30,
          ticks: true,
        ),
        yAxis: pw.FixedAxis(
          [0, 100, 200, 300, 400, 500, 600, 700],
          format: (v) => '\$$v',
          divisions: true,
        ),
      ),
      datasets: [
        pw.BarDataSet(
          color: PdfColors.blue100,
          legend: tableHeaders[2],
          width: 15,
          offset: -10,
          borderColor: baseColor,
          data: List<pw.PointChartValue>.generate(
            dataTable.length,
            (i) {
              final v = dataTable[i][2] as num;
              return pw.PointChartValue(i.toDouble(), v.toDouble());
            },
          ),
        ),
        pw.BarDataSet(
          color: PdfColors.amber100,
          legend: tableHeaders[1],
          width: 15,
          offset: 10,
          borderColor: PdfColors.amber,
          data: List<pw.PointChartValue>.generate(
            dataTable.length,
            (i) {
              final v = dataTable[i][1] as num;
              return pw.PointChartValue(i.toDouble(), v.toDouble());
            },
          ),
        ),
      ],
    );

    // Left curved line chart
    final chart2 = pw.Chart(
      right: pw.ChartLegend(),
      grid: pw.CartesianGrid(
        xAxis: pw.FixedAxis([0, 1, 2, 3, 4, 5, 6]),
        yAxis: pw.FixedAxis(
          [0, 200, 400, 600],
          divisions: true,
        ),
      ),
      datasets: [
        pw.LineDataSet(
          legend: 'Expense',
          drawSurface: true,
          isCurved: true,
          drawPoints: false,
          color: baseColor,
          data: List<pw.PointChartValue>.generate(
            dataTable.length,
            (i) {
              final v = dataTable[i][2] as num;
              return pw.PointChartValue(i.toDouble(), v.toDouble());
            },
          ),
        ),
      ],
    );

    // Data table
    final table = pw.Table.fromTextArray(
      border: null,
      headers: tableHeaders,
      data: List<List<dynamic>>.generate(
        dataTable.length,
        (index) => <dynamic>[
          dataTable[index][0],
          dataTable[index][1],
          dataTable[index][2],
          (dataTable[index][1] as num) - (dataTable[index][2] as num),
        ],
      ),
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontWeight: pw.FontWeight.bold,
      ),
      headerDecoration: const pw.BoxDecoration(
        color: baseColor,
      ),
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: baseColor,
            width: .5,
          ),
        ),
      ),
      cellAlignment: pw.Alignment.centerRight,
      cellAlignments: {0: pw.Alignment.centerLeft},
    );

    // Add page to the PDF
    document.addPage(
      pw.Page(
        pageFormat: pageFormat,
        theme: theme,
        build: (context) {
          // Page layout
          return pw.Column(
            children: [
              pw.Text('Budget Report',
                  style: const pw.TextStyle(
                    color: baseColor,
                    fontSize: 40,
                  )),
              pw.Divider(thickness: 4),
              pw.Expanded(flex: 3, child: chart1),
              pw.Divider(),
              pw.Expanded(flex: 2, child: chart2),
              pw.SizedBox(height: 10),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                      child: pw.Column(children: [
                    pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      padding: const pw.EdgeInsets.only(bottom: 10),
                      child: pw.Text(
                        'Expense By Sub-Categories',
                        style: const pw.TextStyle(
                          color: baseColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    pw.Text(
                      'Total expenses are broken into different categories for closer look into where the money was spent.',
                      textAlign: pw.TextAlign.justify,
                    )
                  ])),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          padding: const pw.EdgeInsets.only(bottom: 10),
                          child: pw.Text(
                            'Spent vs. Saved',
                            style: const pw.TextStyle(
                              color: baseColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        pw.Text(
                          'Budget was originally \$$budget. A total of \$$expense was spent on the month of January which exceeded the overall budget by \$${expense - budget}',
                          textAlign: pw.TextAlign.justify,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Second page with a pie chart
    document.addPage(
      pw.Page(
        pageFormat: pageFormat,
        theme: theme,
        build: (context) {
          const chartColors = [
            PdfColors.blue300,
            PdfColors.green300,
            PdfColors.amber300,
            PdfColors.pink300,
            PdfColors.cyan300,
            PdfColors.purple300,
            PdfColors.lime300,
          ];

          return pw.Column(
            children: [
              pw.Flexible(
                child: pw.Chart(
                  title: pw.Text(
                    'Expense breakdown',
                    style: const pw.TextStyle(
                      color: baseColor,
                      fontSize: 20,
                    ),
                  ),
                  grid: pw.PieGrid(),
                  datasets:
                      List<pw.Dataset>.generate(dataTable.length, (index) {
                    final data = dataTable[index];
                    final color = chartColors[index % chartColors.length];
                    final value = (data[2] as num).toDouble();
                    final pct = (value / expense * 100).round();
                    return pw.PieDataSet(
                      legend: '${data[0]}\n$pct%',
                      value: value,
                      color: color,
                      legendStyle: const pw.TextStyle(fontSize: 10),
                    );
                  }),
                ),
              ),
              table,
            ],
          );
        },
      ),
    );

    // Saves File in Dowloads Folder
    File file = File("C:\\Report\\sSalesReport.pdf");
    file.writeAsBytesSync(await document.save());
  }

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
                    height: MediaQuery.of(context).size.height - 173,
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
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .deepPurple
                                                                    .shade800),
                                                        child: DropdownButton(
                                                          dropdownColor: Colors
                                                              .deepPurple
                                                              .shade800,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          iconEnabledColor:
                                                              Colors.white,
                                                          value: selectedValue,
                                                          items: [
                                                            DropdownMenuItem(
                                                              value: 1,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                  '\t\t\t\t\t\t\t\t2023\t\t\t\t\t\t\t\t'),
                                                            ),
                                                            DropdownMenuItem(
                                                                value: 2,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '\t\t\t\t\t\t\t\t2022\t\t\t\t\t\t\t\t')),
                                                            DropdownMenuItem(
                                                                value: 3,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '\t\t\t\t\t\t\t\t2021\t\t\t\t\t\t\t\t')),
                                                          ],
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedValue =
                                                                  value!;
                                                              if (value == 1) {
                                                                year = 2023;
                                                              } else if (value ==
                                                                  2) {
                                                                year = 2022;
                                                              } else if (value ==
                                                                  3) {
                                                                year = 2021;
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      GFButton(
                                                        onPressed: () =>
                                                            generateReport(),
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
                                                                        15,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Quantity: ${customer[index]['TotalQuantity']}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Price: ${customer[index]['TotalPrice']}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
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
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Quantity: ${employee[index]['Quantity']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Price: ${employee[index]['Price']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
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
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Quantity: ${product[index]['Quantity']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Price: ${product[index]['Price']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
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
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Quantity: ${branch[index]['Quantity']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Price: ${branch[index]['Price']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
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
