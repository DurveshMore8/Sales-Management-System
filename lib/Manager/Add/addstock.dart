// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Manager/stock.dart';

class AddStock extends StatefulWidget {
  AddStock({Key? key}) : super(key: key);

  @override
  AddStockState createState() => AddStockState();
}

class AddStockState extends State<AddStock> {
  //productid, productname, branchname, quantity
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  bool valid = true;
  String error = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controllers[0].text = StockState.addStock['ProductId'];
    controllers[1].text = StockState.addStock['ProductName'];
    controllers[2].text = StockState.addStock['BranchName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[400],
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
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.white,
                            )),
                        Text(
                          'Add Stock',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    Column(
                      children: [
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[0],
                            readOnly: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Nano123',
                              labelText: 'Product Id',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.numbers,
                                  color: Colors.deepPurple.shade500),
                              prefixIconColor: Colors.deepPurple.shade500,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[1],
                            readOnly: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Tata Nexon',
                              labelText: 'Product Name',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.car_repair,
                                  color: Colors.deepPurple.shade500),
                              prefixIconColor: Colors.deepPurple.shade500,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[2],
                            readOnly: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Viviana Mall',
                              labelText: 'Branch Name',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.store,
                                  color: Colors.deepPurple.shade500),
                              prefixIconColor: Colors.deepPurple.shade500,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[3],
                            key: Key('Quantity'),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'e.g., 27',
                              labelText: 'Quantity',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              errorText: error == 'empty'
                                  ? 'Quantity can\'t be empty'
                                  : error == 'outofbound'
                                      ? 'Maximum limit exceeded'
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
                                if (value.length > 2) {
                                  error = 'outofbound';
                                } else {
                                  error = '';
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GFButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                valid = true;
                                if (controllers[3].text == '') {
                                  setState(() {
                                    error = 'empty';
                                    valid = false;
                                  });
                                }
                                if (valid) {
                                  await DB.openCon('stock');
                                  List<Map<String, dynamic>> data =
                                      await DB.collection.find({
                                    'ProductId': controllers[0].text,
                                    'ProductName': controllers[1].text,
                                    'BranchName': controllers[2].text,
                                  }).toList();
                                  await DB.closeCon();
                                  await DB.openCon('stock');
                                  DB.updatestock(
                                      data,
                                      data[0]['Quantity'] +
                                          int.parse(controllers[3].text));
                                  await DB.closeCon();
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              text: 'Confirm',
                              key: Key('Add'),
                              textColor: Colors.white,
                              color: Colors.deepPurple.shade700,
                              hoverColor: Colors.deepPurple.shade500,
                              shape: GFButtonShape.square,
                              size: GFSize.LARGE,
                            ),
                            SizedBox(width: 200),
                            GFButton(
                              onPressed: () {
                                setState(() {
                                  controllers[0].clear();
                                  controllers[1].clear();
                                  controllers[2].clear();
                                  controllers[3].clear();
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              text: 'Clear',
                              textColor: Colors.white,
                              color: Colors.deepPurple.shade700,
                              hoverColor: Colors.deepPurple.shade500,
                              shape: GFButtonShape.square,
                              size: GFSize.LARGE,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )));
  }
}
