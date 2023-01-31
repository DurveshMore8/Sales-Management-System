// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sadms/Database/database.dart';

class Sales extends StatefulWidget {
  Sales({Key? key}) : super(key: key);

  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  TextEditingController text = TextEditingController();
  int selectedValue = 1;
  int selectedPeriod = 1;
  List<Map<String, dynamic>> sales = [];

  void day() async {
    await DB.openCon('sales');
    List<Map<String, dynamic>> s = await DB.collection.find({
      'Date':
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
    }).toList();
    await DB.closeCon();
    setState(() {
      sales.addAll(s);
    });
  }

  void month() async {
    await DB.openCon('sales');
    List<Map<String, dynamic>> s = await DB.collection.find({
      'Date': {
        r'$gte':
            '${DateTime.now().subtract(Duration(days: 30)).day}-${DateTime.now().month}-${DateTime.now().year}'
      }
    }).toList();
    await DB.closeCon();
    setState(() {
      sales.addAll(s);
    });
  }

  void year() async {
    await DB.openCon('sales');
    List<Map<String, dynamic>> s = await DB.collection.find({
      'Date': {
        r'$gte':
            '${DateTime.now().subtract(Duration(days: 365)).day}-${DateTime.now().month}-${DateTime.now().year}'
      }
    }).toList();
    await DB.closeCon();
    setState(() {
      sales.addAll(s);
    });
  }

  @override
  void initState() {
    super.initState();
    day();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Sales',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton(
              dropdownColor: Colors.deepPurple[900],
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white,
              value: selectedValue,
              items: [
                DropdownMenuItem(
                  value: 1,
                  alignment: Alignment.center,
                  child: Text('\t\t\t\t\t\t\t\tEmployee\t\t\t\t\t\t\t\t'),
                ),
                DropdownMenuItem(
                    value: 2,
                    alignment: Alignment.center,
                    child: Text('\t\t\t\t\t\t\t\tProduct\t\t\t\t\t\t\t\t')),
                DropdownMenuItem(
                    value: 3,
                    alignment: Alignment.center,
                    child: Text('\t\t\t\t\t\t\t\tBranch\t\t\t\t\t\t\t\t')),
              ],
              onChanged: (value) {
                setState(() {
                  sales.clear();
                  if (selectedPeriod == 1) {
                    day();
                  } else if (selectedPeriod == 2) {
                    month();
                  } else {}
                  selectedValue = value!;
                  text.clear();
                });
              },
            ),
            DropdownButton(
              dropdownColor: Colors.deepPurple[900],
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white,
              value: selectedPeriod,
              items: [
                DropdownMenuItem(
                  value: 1,
                  alignment: Alignment.center,
                  child: Text('\t\t\t\t\t\t\t\tDaily\t\t\t\t\t\t\t\t'),
                ),
                DropdownMenuItem(
                    value: 2,
                    alignment: Alignment.center,
                    child: Text('\t\t\t\t\t\t\t\tMonthly\t\t\t\t\t\t\t\t')),
                DropdownMenuItem(
                    value: 3,
                    alignment: Alignment.center,
                    child: Text('\t\t\t\t\t\t\t\tYearly\t\t\t\t\t\t\t\t')),
              ],
              onChanged: (value) {
                setState(() {
                  sales.clear();
                  if (value == 1) {
                    day();
                  } else if (value == 2) {
                    month();
                  } else {}
                  selectedPeriod = value!;
                  text.clear();
                });
              },
            ),
          ],
        ),
        SizedBox(height: 50),
        selectedValue == 1
            ? SizedBox(
                width: 750,
                child: TextField(
                  controller: text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Durvesh More',
                    labelText: 'Employee\'s Username',
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
                    setState(() {});
                  },
                ),
              )
            : selectedValue == 2
                ? SizedBox(
                    width: 750,
                    child: TextField(
                      controller: text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Tata Nano',
                        labelText: 'Product\'s Name',
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
                        setState(() {});
                      },
                    ),
                  )
                : SizedBox(
                    width: 750,
                    child: TextField(
                      controller: text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Kisan Nagar Branch',
                        labelText: 'Branch\'s Name',
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
                        setState(() {});
                      },
                    ),
                  ),
        SizedBox(height: 50),
        selectedValue == 1
            ? Expanded(
                child: ListView.builder(
                  itemCount: sales.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.deepPurple[700],
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Name: ${sales[index]['CustomerName']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Phone: ${sales[index]['Phone']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'EmailId: ${sales[index]['EmailId']}',
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
                                    'Attended By: ${sales[index]['SaleBy']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Total Purchase: ${sales[index]['TotalPrice']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Quantity: ${sales[index]['TotalQuantity']}',
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
            : selectedValue == 2
                ? Expanded(
                    child: ListView.builder(
                      itemCount: sales.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.deepPurple[700],
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
                                        'Name: ${sales[index]['CustomerName']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'Phone: ${sales[index]['Phone']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'EmailId: ${sales[index]['EmailId']}',
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
                                        'Product Name: ${sales[index]['Products'][0]['ProductName']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'Total Purchase: ${sales[index]['TotalPrice']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'Quantity: ${sales[index]['TotalQuantity']}',
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
                : selectedValue == 3
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: sales.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.deepPurple[700],
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
                                            'Name: ${sales[index]['CustomerName']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            'Phone: ${sales[index]['Phone']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            'EmailId: ${sales[index]['EmailId']}',
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
                                            'Branch Name: ${sales[index]['BranchName']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            'Total Purchase: ${sales[index]['TotalPrice']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            'Quantity: ${sales[index]['TotalQuantity']}',
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
                    : SizedBox()
      ],
    );
  }
}
