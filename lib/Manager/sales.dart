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
  List<Map<String, dynamic>> search = [];

  void day() async {
    await DB.openCon('sales');
    List<Map<String, dynamic>> s = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      sales.clear();
      search.clear();
      for (int i = 0; i < s.length; i++) {
        int difference =
            DateTime.now().difference(DateTime.parse(s[i]['Date'])).inDays;
        if (difference == 0) {
          if (selectedValue == 2) {
            for (int j = 0; j < s[i]['Products'].length; j++) {
              s[i].remove('ProductName');
              s[i].addAll({'ProductName': s[i]['Products'][j]['ProductName']});
              sales.add(s[i]);
            }
          } else {
            sales.add(s[i]);
            search.add(s[i]);
          }
        }
      }
    });
  }

  void month() async {
    await DB.openCon('sales');
    List<Map<String, dynamic>> s = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      sales.clear();
      search.clear();
      for (int i = 0; i < s.length; i++) {
        int difference =
            DateTime.now().difference(DateTime.parse(s[i]['Date'])).inDays;
        if (difference <= 30) {
          sales.add(s[i]);
          search.add(s[i]);
        }
      }
    });
  }

  void year() async {
    await DB.openCon('sales');
    List<Map<String, dynamic>> s = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      sales.clear();
      search.clear();
      for (int i = 0; i < s.length; i++) {
        int difference =
            DateTime.now().difference(DateTime.parse(s[i]['Date'])).inDays;
        if (difference <= 365) {
          sales.add(s[i]);
          search.add(s[i]);
        }
      }
    });
  }

  void all() async {
    await DB.openCon('sales');
    List<Map<String, dynamic>> s = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      sales.clear();
      search.clear();
      sales.addAll(s);
      search.addAll(s);
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
                  } else {
                    year();
                  }
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
                DropdownMenuItem(
                    value: 4,
                    alignment: Alignment.center,
                    child: Text('\t\t\t\t\t\t\t\tAll\t\t\t\t\t\t\t\t')),
              ],
              onChanged: (value) {
                setState(() {
                  sales.clear();
                  if (value == 1) {
                    day();
                  } else if (value == 2) {
                    month();
                  } else if (value == 3) {
                    year();
                  } else {
                    all();
                  }
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
                    setState(() {
                      sales.clear();
                      if (value == '') {
                        sales.addAll(search);
                      } else {
                        for (int i = 0; i < search.length; i++) {
                          if (value.length <= search[i]['SaleBy'].length) {
                            String namestring = '';
                            for (int j = 0; j < value.length; j++) {
                              namestring = namestring + search[i]['SaleBy'][j];
                            }
                            if (value.toLowerCase() ==
                                namestring.toLowerCase()) {
                              sales.add(search[i]);
                            }
                          }
                        }
                      }
                    });
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
                        setState(() {
                          sales.clear();
                          if (value == '') {
                            sales.addAll(search);
                          } else {
                            for (int i = 0; i < search.length; i++) {
                              if (value.length <=
                                  search[i]['BranchName'].length) {
                                String namestring = '';
                                for (int j = 0; j < value.length; j++) {
                                  namestring =
                                      namestring + search[i]['BranchName'][j];
                                }
                                if (value.toLowerCase() ==
                                    namestring.toLowerCase()) {
                                  sales.add(search[i]);
                                }
                              }
                            }
                          }
                        });
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
                                        'Product Name: ${sales[index]['ProductName']}',
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
