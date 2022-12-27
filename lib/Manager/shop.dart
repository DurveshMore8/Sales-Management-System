// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Manager/Add/addshop.dart';
import 'package:sadms/Manager/Update/updateshop.dart';

class Shop extends StatefulWidget {
  Shop({Key? key}) : super(key: key);

  @override
  ShopState createState() => ShopState();
}

class ShopState extends State<Shop> {
  List<Map<String, dynamic>> data = [];
  static Map<String, dynamic> updateShop = {};
  var text = TextEditingController();
  int selectedvalue = 1;
  int selectedBox = -1;
  List<String> shopid = [];
  List<String> shopname = [];
  List<String> location = [];
  List<String> city = [];
  List<String> state = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Shop',
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
                      child: Text('Shop Name')),
                  DropdownMenuItem(
                      value: 3,
                      alignment: Alignment.center,
                      child: Text('Shop Id')),
                ],
                onChanged: (value) async {
                  shopid.clear();
                  shopname.clear();
                  location.clear();
                  city.clear();
                  state.clear();
                  selectedBox = -1;
                  if (value == 2) {
                    await DB.openCon('shop');
                    data = await DB.collection.find().toList();
                    await DB.closeCon();
                    data.sort((a, b) => a["ShopName"].compareTo(b["ShopName"]));
                    setState(() {
                      selectedvalue = value!;
                      shopname.clear();
                      for (int i = 0; i < data.length; i++) {
                        shopid.add(data[i]['ShopId']);
                        shopname.add(data[i]['ShopName']);
                        location.add(data[i]['Location']);
                        city.add(data[i]['City']);
                        state.add(data[i]['State']);
                      }
                    });
                  } else if (value == 3) {
                    await DB.openCon('shop');
                    data = await DB.collection.find().toList();
                    await DB.closeCon();
                    data.sort((a, b) => a["ShopId"].compareTo(b["ShopId"]));
                    setState(() {
                      selectedvalue = value!;
                      shopname.clear();
                      for (int i = 0; i < data.length; i++) {
                        shopid.add(data[i]['ShopId']);
                        shopname.add(data[i]['ShopName']);
                        location.add(data[i]['Location']);
                        city.add(data[i]['City']);
                        state.add(data[i]['State']);
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
                    hintText: 'Mahaveer Sales',
                    labelText: 'Shop Name',
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
                      shopid.clear();
                      shopname.clear();
                      location.clear();
                      city.clear();
                      state.clear();
                      for (int i = 0; i < data.length; i++) {
                        if (value.length <= data[i]['ShopName'].length) {
                          String shopnamestring = '';
                          for (int j = 0; j < value.length; j++) {
                            shopnamestring =
                                shopnamestring + data[i]['ShopName'][j];
                          }
                          if (value.toLowerCase() ==
                              shopnamestring.toLowerCase()) {
                            shopid.add(data[i]['ShopId']);
                            shopname.add(data[i]['ShopName']);
                            location.add(data[i]['Location']);
                            city.add(data[i]['City']);
                            state.add(data[i]['State']);
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
                        hintText: 'MahSales3429',
                        labelText: 'Shop Id',
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
                          shopid.clear();
                          shopname.clear();
                          location.clear();
                          city.clear();
                          state.clear();
                          for (int i = 0; i < data.length; i++) {
                            if (value.length <= data[i]['ShopId'].length) {
                              String shopidstring = '';
                              for (int j = 0; j < value.length; j++) {
                                shopidstring =
                                    shopidstring + data[i]['ShopId'][j];
                              }
                              if (value.toLowerCase() ==
                                  shopidstring.toLowerCase()) {
                                shopid.add(data[i]['ShopId']);
                                shopname.add(data[i]['ShopName']);
                                location.add(data[i]['Location']);
                                city.add(data[i]['City']);
                                state.add(data[i]['State']);
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
                    MaterialPageRoute(builder: ((context) => AddShop())));
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
                  updateShop = data[selectedBox];
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => UpdateShop())));
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
                  await DB.openCon('shop');
                  await DB.collection
                      .remove({'ShopId': data[selectedBox]['ShopId']});
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
                  itemCount: shopname.length,
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
                                    'Shop Name: ${shopname[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Location: ${location[index]}',
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
                                    'Shop Id: ${shopid[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'City: ${city[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'State: ${state[index]}',
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
                        itemCount: shopid.length,
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
                                          'Shop Id: ${shopid[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Location: ${location[index]}',
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
                                          'Shop Name: ${shopname[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'City: ${city[index]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'State: ${state[index]}',
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
