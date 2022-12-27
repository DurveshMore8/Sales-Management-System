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
  var productid = TextEditingController();
  var productname = TextEditingController();
  var costprice = TextEditingController();
  var sellingprice = TextEditingController();
  var description = TextEditingController();

  @override
  void initState() {
    super.initState();
    productid.text = ProductState.updateProduct['ProductId'];
    productname.text = ProductState.updateProduct['ProductName'];
    costprice.text = ProductState.updateProduct['CostPrice'].toString();
    sellingprice.text = ProductState.updateProduct['SellingPrice'].toString();
    description.text = ProductState.updateProduct['Description'];
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
                    controller: productid,
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
                      prefixIcon: Icon(Icons.numbers),
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
                    controller: productname,
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
                      prefixIcon: Icon(Icons.production_quantity_limits),
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
                    controller: costprice,
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
                      prefixIcon: Icon(Icons.price_check),
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
                    controller: sellingprice,
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
                      prefixIcon: Icon(Icons.price_change),
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
                    controller: description,
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
                      prefixIcon: Icon(Icons.description),
                      prefixIconColor: Colors.deepPurple.shade500,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GFButton(
                      onPressed: () async {
                        await DB.openCon('product');
                        await DB.updatedata('ProductId', productid.text,
                            'ProductName', productname.text);
                        await DB.updatedata('ProductId', productid.text,
                            'CostPrice', int.parse(costprice.text));
                        await DB.updatedata('ProductId', productid.text,
                            'SellingPrice', int.parse(sellingprice.text));
                        await DB.updatedata('ProductId', productid.text,
                            'Description', description.text);
                        await DB.closeCon();
                        Navigator.pop(context);
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
                          productid.clear();
                          productname.clear();
                          costprice.clear();
                          sellingprice.clear();
                          description.clear();
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
