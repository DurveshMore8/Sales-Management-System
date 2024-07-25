// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Manager/Add/addproduct.dart';
import 'package:sales_management_system/Manager/Update/updateproduct.dart';

class Product extends StatefulWidget {
  Product({Key? key}) : super(key: key);

  @override
  ProductState createState() => ProductState();
}

class ProductState extends State<Product> {
  static List<Map<String, dynamic>> maindata = [];
  List<Map<String, dynamic>> data = [];
  static Map<String, dynamic> updateProduct = {};
  var text = TextEditingController();
  int selectedBox = -1;
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    data.clear();
    await DB.openCon('product');
    maindata = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      data.addAll(maindata);
      maindata.sort((a, b) => a['ProductName'].compareTo(b['ProductName']));
      data.sort((a, b) => a['ProductName'].compareTo(b['ProductName']));
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
                    'Product',
                    key: Key('Title_Product'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 750,
                    child: TextField(
                      controller: text,
                      key: Key('Search'),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Tata Nano',
                        labelText: 'Product Name',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        labelStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.deepPurple.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(
                          Icons.text_format_outlined,
                          color: Colors.deepPurple.shade500,
                        ),
                        prefixIconColor: Colors.deepPurple.shade500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          data.clear();
                          if (value == '') {
                            data.addAll(maindata);
                          } else {
                            for (int i = 0; i < maindata.length; i++) {
                              if (value.length <=
                                  maindata[i]['ProductName'].length) {
                                String productnamestring = '';
                                for (int j = 0; j < value.length; j++) {
                                  productnamestring = productnamestring +
                                      maindata[i]['ProductName'][j];
                                }
                                if (value.toLowerCase() ==
                                    productnamestring.toLowerCase()) {
                                  data.add(maindata[i]);
                                }
                              }
                            }
                          }
                          selectedBox = -1;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GFButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => AddProduct())))
                              .whenComplete(() {
                            text.clear();
                            selectedBox = -1;
                            getData();
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          key: Key('Add'),
                          color: Colors.green,
                        ),
                        text: 'Add',
                        textColor: Colors.white,
                        color: Colors.deepPurple.shade700,
                        hoverColor: Colors.deepPurple.shade500,
                        shape: GFButtonShape.square,
                        size: GFSize.LARGE,
                      ),
                      SizedBox(width: 75),
                      GFButton(
                        onPressed: () {
                          if (selectedBox > -1) {
                            updateProduct = data[selectedBox];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        UpdateProduct()))).whenComplete(() {
                              text.clear();
                              selectedBox = -1;
                              getData();
                            });
                          }
                        },
                        icon: Icon(
                          Icons.update,
                          color: Colors.blue,
                        ),
                        text: 'Update',
                        key: Key('Update'),
                        textColor: Colors.white,
                        color: Colors.deepPurple.shade700,
                        hoverColor: Colors.deepPurple.shade500,
                        shape: GFButtonShape.square,
                        size: GFSize.LARGE,
                      ),
                      SizedBox(width: 75),
                      GFButton(
                        onPressed: () async {
                          if (selectedBox > -1) {
                            setState(() {
                              isLoading = true;
                            });
                            await DB.openCon('product');
                            await DB.collection.remove(
                                {'ProductId': data[selectedBox]['ProductId']});
                            await DB.closeCon();
                            await DB.openCon('stock');
                            await DB.collection.remove(
                                {'ProductId': data[selectedBox]['ProductId']});
                            await DB.closeCon();
                            selectedBox = -1;
                            setState(() {
                              getData();
                              isLoading = false;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        text: 'Delete',
                        key: Key('Delete'),
                        textColor: Colors.white,
                        color: Colors.deepPurple.shade700,
                        hoverColor: Colors.deepPurple.shade500,
                        shape: GFButtonShape.square,
                        size: GFSize.LARGE,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.isEmpty ? 1 : data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBox = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: data.isEmpty
                                ? Center(
                                    child: Text(
                                      'No Product Available',
                                      key: Key('Message'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Container(
                                    color: selectedBox == index
                                        ? Colors.deepPurple[900]
                                        : Colors.deepPurple[700],
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
                                              'Product Name: ${data[index]['ProductName']}',
                                              key: Key('ProductName'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Cost Price: ${data[index]['CostPrice']}',
                                              key: Key('CostPrice'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Selling Price: ${data[index]['SellingPrice']}',
                                              key: Key('SellingPrice'),
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
                                              'Product Id: ${data[index]['ProductId']}',
                                              key: Key('ProductId'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Description: ${data[index]['Description']}',
                                              key: Key('Description'),
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
                ],
              ));
  }
}
