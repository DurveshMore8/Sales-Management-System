// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Login/login.dart';

class AddSales extends StatefulWidget {
  AddSales({Key? key}) : super(key: key);

  @override
  AddSalesState createState() => AddSalesState();
}

class AddSalesState extends State<AddSales> {
  //branchid, branchname, location, city, state
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  List<String> error = ['', '', '', ''];
  bool valid = true;
  List<Map<String, dynamic>> stock = [];
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> employee = [];
  List<Map<String, dynamic>> order = [];
  static List<int> total = [0, 0];

  void getData() async {
    await DB.openCon('stock');
    stock = await DB.collection.find().toList();
    await DB.closeCon();
    await DB.openCon('product');
    product = await DB.collection.find().toList();
    await DB.closeCon();
    await DB.openCon('employeeinfo');
    employee =
        await DB.collection.find({"Username": LoginState.employee}).toList();
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
                              for (int i = 0; i < stock.length; i++) {
                                if (value == stock[i]['ProductName'] &&
                                    stock[i]['Quantity'] != 0 &&
                                    employee[0]['BranchName'] ==
                                        stock[i]['BranchName']) {
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
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 600,
                        child: TextField(
                          controller: controllers[2],
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ], // Only numbers can be entered
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: '20',
                            labelText: 'Quantity',
                            labelStyle: TextStyle(
                                backgroundColor: Colors.white,
                                color: Colors.deepPurple.shade500,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            errorText: error[2] == 'empty'
                                ? 'Quantity Can\'t be empty'
                                : error[2] == 'maximum'
                                    ? 'Maximum Limit is Exceeded'
                                    : null,
                            prefixIcon: Icon(Icons.production_quantity_limits,
                                color: Colors.deepPurple.shade500),
                            prefixIconColor: Colors.deepPurple.shade500,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                if (value.length > 4) {
                                  error[2] = 'maximum';
                                } else {
                                  error[2] = '';
                                }
                              }
                            });
                          },
                          onSubmitted: ((value) {
                            setState(() {
                              controllers[3].text =
                                  (int.parse(controllers[1].text) *
                                          int.parse(controllers[2].text))
                                      .toString();
                            });
                          }),
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: TextField(
                          controller: controllers[3],
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ], // Only numbers can be entered
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: '4500000',
                            labelText: 'Total',
                            labelStyle: TextStyle(
                                backgroundColor: Colors.white,
                                color: Colors.deepPurple.shade500,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            errorText: error[3] == 'empty'
                                ? 'Total Can\'t be empty'
                                : error[3] == 'minimum'
                                    ? 'Minimum Limit is not Reached'
                                    : error[3] == 'maximum'
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
                                if (value.length < 3) {
                                  error[3] = 'minimum';
                                } else if (value.length > 10) {
                                  error[3] = 'maximum';
                                } else {
                                  error[3] = '';
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GFButton(
                      onPressed: () {
                        setState(() {
                          order.add({
                            'ProductName': controllers[0].text,
                            'Quantity': controllers[2].text,
                            'Price': controllers[3].text
                          });
                          total[0] += int.parse(controllers[2].text);
                          total[1] += int.parse(controllers[3].text);
                          controllers[0].clear();
                          controllers[1].clear();
                          controllers[2].clear();
                          controllers[3].clear();
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      text: 'Add Product',
                      textColor: Colors.white,
                      color: Colors.deepPurple.shade700,
                      hoverColor: Colors.deepPurple.shade500,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                    ),
                    GFButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.production_quantity_limits,
                        color: Colors.green,
                      ),
                      text: 'Cart Completed',
                      textColor: Colors.white,
                      color: Colors.deepPurple.shade700,
                      hoverColor: Colors.deepPurple.shade500,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 300,
              child: Expanded(
                child: ListView.builder(
                  itemCount: order.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.deepPurple[700],
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Product Name: ${order[index]['ProductName']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Quantity: ${order[index]['Quantity']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Price: ${order[index]['Price']}',
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
            ),
            SizedBox(height: 25),
            Container(
                width: MediaQuery.of(context).size.width - 10,
                height: 40,
                color: Colors.deepPurple[700],
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Total Quantity: ${total[0]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'Total Price: ${total[1]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                )),
          ])),
    );
  }
}
