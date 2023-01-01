// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Manager/Add/addproduct.dart';
import 'package:sadms/Manager/Update/updateproduct.dart';

class Product extends StatefulWidget {
  Product({Key? key}) : super(key: key);

  @override
  ProductState createState() => ProductState();
}

class ProductState extends State<Product> {
  List<Map<String, dynamic>> data = [];
  static Map<String, dynamic> updateProduct = {};
  var text = TextEditingController();
  int selectedvalue = 1;
  int selectedBox = -1;
  List<String> productid = [];
  List<String> productname = [];
  List<int> costprice = [];
  List<int> sellingprice = [];
  List<String> description = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sort By:",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 30),
            DropdownButton(
                dropdownColor: Colors.deepPurple[600],
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
                value: selectedvalue,
                items: [
                  DropdownMenuItem(
                    value: 1,
                    alignment: Alignment.center,
                    child: Text('--Select Type--'),
                  ),
                  DropdownMenuItem(
                      value: 2,
                      alignment: Alignment.center,
                      child: Text('Product Name')),
                  DropdownMenuItem(
                      value: 3,
                      alignment: Alignment.center,
                      child: Text('Product Id')),
                ],
                onChanged: (value) async {
                  productid.clear();
                  productname.clear();
                  costprice.clear();
                  sellingprice.clear();
                  description.clear();
                  selectedBox = -1;
                  if (value == 2) {
                    await DB.openCon('product');
                    data = await DB.collection.find().toList();
                    await DB.closeCon();
                    data.sort(
                        (a, b) => a["ProductName"].compareTo(b["ProductName"]));
                    setState(() {
                      selectedvalue = value!;
                      productname.clear();
                      for (int i = 0; i < data.length; i++) {
                        productid.add(data[i]['ProductId']);
                        productname.add(data[i]['ProductName']);
                        costprice.add(data[i]['CostPrice']);
                        sellingprice.add(data[i]['SellingPrice']);
                        description.add(data[i]['Description']);
                      }
                    });
                  } else if (value == 3) {
                    await DB.openCon('product');
                    data = await DB.collection.find().toList();
                    await DB.closeCon();
                    data.sort(
                        (a, b) => a["ProductId"].compareTo(b["ProductId"]));
                    setState(() {
                      selectedvalue = value!;
                      productname.clear();
                      for (int i = 0; i < data.length; i++) {
                        productid.add(data[i]['ProductId']);
                        productname.add(data[i]['ProductName']);
                        costprice.add(data[i]['CostPrice']);
                        sellingprice.add(data[i]['SellingPrice']);
                        description.add(data[i]['Description']);
                      }
                    });
                  } else {
                    setState(() {
                      selectedvalue = value!;
                    });
                  }
                }),
          ],
        ),
        SizedBox(height: 50),
        selectedvalue == 2
            ? SizedBox(
                width: 750,
                child: TextField(
                  controller: text,
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
                    prefixIcon: Icon(Icons.text_format_outlined),
                    prefixIconColor: Colors.deepPurple.shade500,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      productid.clear();
                      productname.clear();
                      costprice.clear();
                      sellingprice.clear();
                      description.clear();
                      for (int i = 0; i < data.length; i++) {
                        if (value.length <= data[i]['ProductName'].length) {
                          String productnamestring = '';
                          for (int j = 0; j < value.length; j++) {
                            productnamestring =
                                productnamestring + data[i]['ProductName'][j];
                          }
                          if (value.toLowerCase() ==
                              productnamestring.toLowerCase()) {
                            productid.add(data[i]['ProductId']);
                            productname.add(data[i]['ProductName']);
                            costprice.add(data[i]['CostPrice']);
                            sellingprice.add(data[i]['SellingPrice']);
                            description.add(data[i]['Description']);
                          }
                        }
                      }
                    });
                  },
                ),
              )
            : selectedvalue == 3
                ? SizedBox(
                    width: 750,
                    child: TextField(
                      controller: text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'nano3429',
                        labelText: 'Product Id',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        labelStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.deepPurple.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.text_format_outlined),
                        prefixIconColor: Colors.deepPurple.shade500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          productid.clear();
                          productname.clear();
                          costprice.clear();
                          sellingprice.clear();
                          description.clear();
                          for (int i = 0; i < data.length; i++) {
                            if (value.length <= data[i]['ProductId'].length) {
                              String productidstring = '';
                              for (int j = 0; j < value.length; j++) {
                                productidstring =
                                    productidstring + data[i]['ProductId'][j];
                              }
                              if (value.toLowerCase() ==
                                  productidstring.toLowerCase()) {
                                productid.add(data[i]['ProductId']);
                                productname.add(data[i]['ProductName']);
                                costprice.add(data[i]['CostPrice']);
                                sellingprice.add(data[i]['SellingPrice']);
                                description.add(data[i]['Description']);
                              }
                            }
                          }
                        });
                      },
                    ),
                  )
                : SizedBox(),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GFButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddProduct())));
              },
              icon: Icon(
                Icons.add,
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
                          builder: ((context) => UpdateProduct())));
                }
              },
              icon: Icon(
                Icons.update,
                color: Colors.blue,
              ),
              text: 'Update',
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
                  await DB.openCon('product');
                  await DB.collection
                      .remove({'ProductId': data[selectedBox]['ProductId']});
                  await DB.closeCon();
                  await DB.openCon('stock');
                  await DB.collection
                      .remove({'ProductId': data[selectedBox]['ProductId']});
                  await DB.closeCon();
                  setState(() {
                    selectedvalue = 1;
                  });
                }
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              text: 'Delete',
              textColor: Colors.white,
              color: Colors.deepPurple.shade700,
              hoverColor: Colors.deepPurple.shade500,
              shape: GFButtonShape.square,
              size: GFSize.LARGE,
            ),
          ],
        ),
        SizedBox(height: 50),
        selectedvalue == 2
            ? Expanded(
                child: ListView.builder(
                  itemCount: productname.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBox = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: selectedBox == index
                              ? Colors.deepPurple[900]
                              : Colors.deepPurple[700],
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Product Name: ${productname[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Cost Price: ${costprice[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Selling Price: ${sellingprice[index]}',
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
                                    'Product Id: ${productid[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Description: ${description[index]}',
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
            : selectedvalue == 3
                ? Expanded(
                    child: ListView.builder(
                        itemCount: productid.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedBox = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
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
                                          'Product Id: ${productid[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'CostPrice: ${costprice[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Selling Price: ${sellingprice[index]}',
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
                                          'Product Name: ${productname[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Description: ${description[index]}',
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
                        }))
                : SizedBox(),
      ],
    );
  }
}
