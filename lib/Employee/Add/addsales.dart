// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Login/login.dart';

class AddSales extends StatefulWidget {
  AddSales({Key? key}) : super(key: key);

  @override
  AddSalesState createState() => AddSalesState();
}

class AddSalesState extends State<AddSales> {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  List<String> error = ['', '', '', ''];
  int quantity = 0;
  bool isLoading = true;
  bool isValid = true;
  bool price = false;
  List<Map<String, dynamic>> stock = [];
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> employee = [];
  static List<Map<String, dynamic>> order = [];
  static List<int> total = [0, 0];

  void getData() async {
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade400,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 600,
                                    child: TextField(
                                      controller: controllers[0],
                                      key: Key('Product'),
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
                                            ? 'Product Name Can\'t be empty'
                                            : error[0] == 'minimum'
                                                ? 'Minimum Limit is not Reached'
                                                : error[0] == 'maximum'
                                                    ? 'Maximum Limit is Exceeded'
                                                    : error[0] == 'not exist'
                                                        ? 'Product doesn\'t exist'
                                                        : null,
                                        prefixIcon: Icon(Icons.person,
                                            color: Colors.deepPurple.shade500),
                                        prefixIconColor:
                                            Colors.deepPurple.shade500,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.horizontal(),
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
                                        if (stock.isNotEmpty &&
                                            employee.isNotEmpty) {
                                          bool exist = false;
                                          setState(() {
                                            for (int i = 0;
                                                i < stock.length;
                                                i++) {
                                              if (value ==
                                                      stock[i]['ProductName'] &&
                                                  stock[i]['Quantity'] != 0 &&
                                                  employee[0]['BranchName'] ==
                                                      stock[i]['BranchName']) {
                                                exist = true;
                                                for (int j = 0;
                                                    j < product.length;
                                                    j++) {
                                                  if (value ==
                                                      product[j]
                                                          ['ProductName']) {
                                                    controllers[1].text =
                                                        product[j]
                                                                ['SellingPrice']
                                                            .toString();
                                                    quantity =
                                                        stock[i]['Quantity'];
                                                    price = true;
                                                    error[1] = '';
                                                  }
                                                }
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
                                              price = false;
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 600,
                                    child: TextField(
                                      controller: controllers[1],
                                      key: Key('Selling'),
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
                                        prefixIconColor:
                                            Colors.deepPurple.shade500,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.horizontal(),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value.isNotEmpty) {
                                            if (value.length < 5) {
                                              error[1] = 'minimum';
                                              price = false;
                                            } else if (value.length > 8) {
                                              error[1] = 'maximum';
                                              price = false;
                                            } else {
                                              error[1] = '';
                                              price = true;
                                            }
                                          } else {
                                            price = false;
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 600,
                                    child: TextField(
                                      readOnly: price ? false : true,
                                      controller: controllers[2],
                                      key: Key('Quantity'),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ], // Only numbers can be entered
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Available: $quantity',
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
                                                : error[2] == 'exceed'
                                                    ? 'Quantity exceeded'
                                                    : null,
                                        prefixIcon: Icon(
                                            Icons.production_quantity_limits,
                                            color: Colors.deepPurple.shade500),
                                        prefixIconColor:
                                            Colors.deepPurple.shade500,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.horizontal(),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        controllers[3].clear();
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
                                          if (quantity <
                                              int.parse(value.toString())) {
                                            error[2] = 'exceed';
                                          } else {
                                            error[2] = '';
                                            error[3] = '';
                                            if (controllers[2]
                                                    .text
                                                    .isNotEmpty ||
                                                controllers[3]
                                                    .text
                                                    .isNotEmpty) {
                                              error[2] = '';
                                              controllers[3].text = (int.parse(
                                                          controllers[1].text) *
                                                      int.parse(
                                                          controllers[2].text))
                                                  .toString();
                                            }
                                          }
                                        });
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 600,
                                    child: TextField(
                                      controller: controllers[3],
                                      key: Key('Total'),
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
                                            ? 'Total Price Can\'t be empty'
                                            : null,
                                        prefixIcon: Icon(Icons.price_change,
                                            color: Colors.deepPurple.shade500),
                                        prefixIconColor:
                                            Colors.deepPurple.shade500,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.horizontal(),
                                        ),
                                      ),
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
                                      isValid = true;
                                      for (int i = 0; i < 4; i++) {
                                        if (controllers[i].text.isEmpty) {
                                          error[i] = 'empty';
                                        }
                                      }
                                      for (int i = 0; i < 4; i++) {
                                        if (error[i] != '') {
                                          isValid = false;
                                        }
                                      }
                                      if (isValid) {
                                        order.add({
                                          'ProductName': controllers[0].text,
                                          'Quantity': controllers[2].text,
                                          'Price': controllers[3].text
                                        });
                                        total[0] +=
                                            int.parse(controllers[2].text);
                                        total[1] +=
                                            int.parse(controllers[3].text);
                                        for (int i = 0; i <= 3; i++) {
                                          controllers[i].clear();
                                        }
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                  text: 'Add Product',
                                  key: Key('Add'),
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
                                  key: Key('Complete'),
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: order.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.deepPurple.shade700,
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Product Name: ${order[index]['ProductName']}',
                                              key: Key('ProductName'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Quantity: ${order[index]['Quantity']}',
                                              key: Key('TQuantity'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Price: ${order[index]['Price']}',
                                              key: Key('TPrice'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    total[0] -= int.parse(
                                                        order[index]
                                                            ['Quantity']);
                                                    total[1] -= int.parse(
                                                        order[index]['Price']);
                                                    order.removeAt(index);
                                                  });
                                                },
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
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
                        SizedBox(height: 25),
                        Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: 40,
                            color: Colors.deepPurple.shade700,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                      ])));
  }
}
