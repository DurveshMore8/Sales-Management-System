// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';

class AddShop extends StatefulWidget {
  AddShop({Key? key}) : super(key: key);

  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  var shopid = TextEditingController();
  var shopname = TextEditingController();
  var location = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();

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
                  'Add Shop',
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
                    controller: shopid,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'MahaSale123',
                      labelText: 'Shop Id',
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
                    controller: shopname,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Mahaveer Sales',
                      labelText: 'Shop Name',
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
                    controller: location, // Only numbers can be entered
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Near S.V Road',
                      labelText: 'Location',
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
                    controller: city, // Only numbers can be entered
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Mumbai',
                      labelText: 'City',
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
                    controller: state,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Maharashtra',
                      labelText: 'State',
                      labelStyle: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepPurple.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      prefixIcon: Icon(Icons.countertops),
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
                        Map<String, dynamic> query = {
                          'ShopId': shopid.text,
                          'ShopName': shopname.text,
                          'Location': location.text,
                          'City': city.text,
                          'State': state.text,
                        };
                        await DB.openCon('shop');
                        await DB.collection.insertOne(query);
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
                          shopid.clear();
                          shopname.clear();
                          location.clear();
                          city.clear();
                          state.clear();
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
          ])),
    );
  }
}
