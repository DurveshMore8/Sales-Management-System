// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Manager/product.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({Key? key}) : super(key: key);

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  List<String> error = ['', '', '', '', ''];
  bool valid = true;

  @override
  void initState() {
    super.initState();
    controllers[0].text = ProductState.updateProduct['ProductId'];
    controllers[1].text = ProductState.updateProduct['ProductName'];
    controllers[2].text = ProductState.updateProduct['CostPrice'].toString();
    controllers[3].text = ProductState.updateProduct['SellingPrice'].toString();
    controllers[4].text = ProductState.updateProduct['Description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                  'Update Product',
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
                      errorText: error[0] == 'empty'
                          ? 'Product Id Can\'t be empty'
                          : error[0] == 'minimum'
                              ? 'Minimum Limit is not Reached'
                              : error[0] == 'maximum'
                                  ? 'Maximum Limit is Exceeded'
                                  : null,
                      prefixIcon: Icon(Icons.numbers),
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
                          } else if (value.length > 10) {
                            error[0] = 'maximum';
                          } else {
                            error[0] = '';
                          }
                        }
                      });
                    },
                  ),
                ),
                error[0] == '' ? SizedBox(height: 39) : SizedBox(height: 15),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: controllers[1],
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
                      errorText: error[1] == 'empty'
                          ? 'Product Name Can\'t be empty'
                          : error[1] == 'minimum'
                              ? 'Minimum Limit is not Reached'
                              : error[1] == 'maximum'
                                  ? 'Maximum Limit is Exceeded'
                                  : null,
                      prefixIcon: Icon(Icons.production_quantity_limits),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          if (value.length < 4) {
                            error[1] = 'minimum';
                          } else if (value.length > 20) {
                            error[1] = 'maximum';
                          } else {
                            error[1] = '';
                          }
                        }
                      });
                    },
                  ),
                ),
                error[1] == '' ? SizedBox(height: 39) : SizedBox(height: 15),
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
                      hintText: '250000',
                      labelText: 'Cost Price',
                      labelStyle: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepPurple.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      errorText: error[2] == 'empty'
                          ? 'Cost Price Can\'t be empty'
                          : error[2] == 'minimum'
                              ? 'Minimum Limit is not Reached'
                              : error[2] == 'maximum'
                                  ? 'Maximum Limit is Exceeded'
                                  : null,
                      prefixIcon: Icon(Icons.price_check),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          if (value.length < 5) {
                            error[2] = 'minimum';
                          } else if (value.length > 8) {
                            error[2] = 'maximum';
                          } else {
                            error[2] = '';
                          }
                        }
                      });
                    },
                  ),
                ),
                error[2] == '' ? SizedBox(height: 39) : SizedBox(height: 15),
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
                      hintText: '450000',
                      labelText: 'Selling Price',
                      labelStyle: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepPurple.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      errorText: error[3] == 'empty'
                          ? 'Selling Price Can\'t be empty'
                          : error[3] == 'minimum'
                              ? 'Minimum Limit is not Reached'
                              : error[3] == 'maximum'
                                  ? 'Maximum Limit is Exceeded'
                                  : null,
                      prefixIcon: Icon(Icons.price_change),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          if (value.length < 5) {
                            error[3] = 'minimum';
                          } else if (value.length > 8) {
                            error[3] = 'maximum';
                          } else {
                            error[3] = '';
                          }
                        }
                      });
                    },
                  ),
                ),
                error[3] == '' ? SizedBox(height: 39) : SizedBox(height: 15),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: controllers[4],
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Product is Well Maintained and Prefect',
                      labelText: 'Description',
                      labelStyle: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepPurple.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      errorText: error[4] == 'empty'
                          ? 'Descrption Can\'t be empty'
                          : error[4] == 'minimum'
                              ? 'Minimum Limit is not Reached'
                              : error[4] == 'maximum'
                                  ? 'Maximum Limit is Exceeded'
                                  : null,
                      prefixIcon: Icon(Icons.description),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          if (value.length < 10) {
                            error[4] = 'minimum';
                          } else if (value.length > 40) {
                            error[4] = 'maximum';
                          } else {
                            error[4] = '';
                          }
                        }
                      });
                    },
                  ),
                ),
                error[4] == '' ? SizedBox(height: 50) : SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GFButton(
                      onPressed: () async {
                        valid = true;
                        setState(() {
                          for (int i = 0; i < 5; i++) {
                            if (controllers[i].text == '') {
                              error[i] = 'empty';
                            }
                          }
                          for (int i = 0; i < 5; i++) {
                            if (controllers[i].text == '') {
                              valid = false;
                            }
                          }
                        });
                        if (valid) {
                          await DB.openCon('product');
                          await DB.updatedata('ProductId', controllers[0].text,
                              'ProductName', controllers[1].text);
                          await DB.updatedata('ProductId', controllers[0].text,
                              'CostPrice', int.parse(controllers[2].text));
                          await DB.updatedata('ProductId', controllers[0].text,
                              'SellingPrice', int.parse(controllers[3].text));
                          await DB.updatedata('ProductId', controllers[0].text,
                              'Description', controllers[4].text);
                          await DB.closeCon();
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      text: 'Confirm',
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
                          controllers[4].clear();
                        });
                      },
                      icon: Icon(
                        Icons.clear,
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
          ])),
    );
  }
}
