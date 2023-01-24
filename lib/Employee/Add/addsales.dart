// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadms/Database/database.dart';

class AddSales extends StatefulWidget {
  AddSales({Key? key}) : super(key: key);

  @override
  AddSalesState createState() => AddSalesState();
}

class AddSalesState extends State<AddSales> {
  //branchid, branchname, location, city, state
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  List<String> error = ['', '', '', '', ''];
  bool valid = true;
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> product = [];

  void getData() async {
    await DB.openCon('stock');
    data = await DB.collection.find().toList();
    await DB.closeCon();
    await DB.openCon('product');
    product = await DB.collection.find().toList();
    await DB.closeCon();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                    )),
                const Text(
                  'Add Sales',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 600,
                        child: TextField(
                          controller: controllers[0],
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Nano',
                            labelText: 'Product Name',
                            labelStyle: TextStyle(
                                backgroundColor: Colors.white,
                                color: Colors.deepPurple.shade500,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            errorText: error[0] == 'empty'
                                ? 'Customer\'s Name Can\'t be empty'
                                : error[0] == 'minimum'
                                    ? 'Minimum Limit is not Reached'
                                    : error[0] == 'maximum'
                                        ? 'Maximum Limit is Exceeded'
                                        : error[0] == 'not exist'
                                            ? 'Product doesn\'t exist'
                                            : null,
                            prefixIcon: Icon(Icons.person,
                                color: Colors.deepPurple.shade500),
                            prefixIconColor: Colors.deepPurple.shade500,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                if (value.length < 4) {
                                  error[0] = 'minimum';
                                } else if (value.length > 20) {
                                  error[0] = 'maximum';
                                } else {
                                  error[0] = '';
                                }
                              }
                            });
                          },
                          onSubmitted: (value) {
                            bool exist = false;
                            setState(() {
                              for (int i = 0; i < data.length; i++) {
                                if (value == data[i]['ProductName'] &&
                                    data[i]['Quantity'] != 0) {
                                  exist = true;
                                  controllers[1].text =
                                      product[i]['SellingPrice'].toString();
                                  break;
                                }
                              }
                              if (exist == true) {
                                error[0] = '';
                              } else {
                                error[0] = 'not exist';
                                controllers[1].clear();
                                controllers[2].clear();
                                controllers[3].clear();
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: TextField(
                          controller: controllers[1],
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ], // Only numbers can be entered
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: '450000',
                            labelText: 'Selling Price',
                            labelStyle: TextStyle(
                                backgroundColor: Colors.white,
                                color: Colors.deepPurple.shade500,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            errorText: error[1] == 'empty'
                                ? 'Selling Price Can\'t be empty'
                                : error[1] == 'minimum'
                                    ? 'Minimum Limit is not Reached'
                                    : error[1] == 'maximum'
                                        ? 'Maximum Limit is Exceeded'
                                        : null,
                            prefixIcon: Icon(Icons.price_change,
                                color: Colors.deepPurple.shade500),
                            prefixIconColor: Colors.deepPurple.shade500,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                if (value.length < 5) {
                                  error[1] = 'minimum';
                                } else if (value.length > 8) {
                                  error[1] = 'maximum';
                                } else {
                                  error[1] = '';
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
