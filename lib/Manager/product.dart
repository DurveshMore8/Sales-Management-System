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
  static List<Map<String, dynamic>> maindata = [];
  List<Map<String, dynamic>> data = [];
  static Map<String, dynamic> updateProduct = {};
  var text = TextEditingController();
  int selectedBox = -1;

  void getData() async {
    data.clear();
    await DB.openCon('product');
    maindata = await DB.collection.find().toList();
    await DB.closeCon();
    setState(() {
      data.addAll(maindata);
      maindata.sort((a, b) => a['ProductName'].compareTo(b['ProductName']));
      data.sort((a, b) => a['ProductName'].compareTo(b['ProductName']));
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
        SizedBox(
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
                    if (value.length <= maindata[i]['ProductName'].length) {
                      String productnamestring = '';
                      for (int j = 0; j < value.length; j++) {
                        productnamestring =
                            productnamestring + maindata[i]['ProductName'][j];
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
                Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => AddProduct())))
                    .whenComplete(() {
                  getData();
                  text.clear();
                  selectedBox = -1;
                });
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
                              builder: ((context) => UpdateProduct())))
                      .whenComplete(() {
                    getData();
                    text.clear();
                    selectedBox = -1;
                  });
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
                  getData();
                  selectedBox = -1;
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
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Product Name: ${data[index]['ProductName']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'Cost Price: ${data[index]['CostPrice']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'Selling Price: ${data[index]['SellingPrice']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Product Id: ${data[index]['ProductId']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'Description: ${data[index]['Description']}',
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
    );
  }
}
