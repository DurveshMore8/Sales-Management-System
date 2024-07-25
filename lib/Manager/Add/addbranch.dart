// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Login/login.dart';
import 'package:sales_management_system/Manager/branch.dart';

class AddBranch extends StatefulWidget {
  AddBranch({Key? key}) : super(key: key);

  @override
  _AddBranchState createState() => _AddBranchState();
}

class _AddBranchState extends State<AddBranch> {
  //branchid, branchname, location, city, state
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  List<String> error = ['', '', '', '', ''];
  bool valid = true;
  bool isLoading = false;

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
                          'Add Branch',
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
                            key: Key('BranchId'),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'MahaSale123',
                              labelText: 'Branch Id',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              errorText: error[0] == 'empty'
                                  ? 'Branch Id Can\'t be empty'
                                  : error[0] == 'minimum'
                                      ? 'Minimum Limit is not Reached'
                                      : error[0] == 'maximum'
                                          ? 'Maximum Limit is Exceeded'
                                          : error[0] == 'already exist'
                                              ? 'Branch Id already exist'
                                              : null,
                              prefixIcon: Icon(Icons.numbers,
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
                                    error[0] = 'minimum';
                                  } else if (value.length > 20) {
                                    error[0] = 'maximum';
                                  } else {
                                    error[0] = '';
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        error[0] == ''
                            ? SizedBox(height: 39)
                            : SizedBox(height: 15),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[1],
                            key: Key('BranchName'),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Viviana Mall Branch',
                              labelText: 'Branch Name',
                              labelStyle: TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              errorText: error[1] == 'empty'
                                  ? 'Branch Name Can\'t be empty'
                                  : error[1] == 'minimum'
                                      ? 'Minimum Limit is not Reached'
                                      : error[1] == 'maximum'
                                          ? 'Maximum Limit is Exceeded'
                                          : null,
                              prefixIcon: Icon(Icons.store,
                                  color: Colors.deepPurple.shade500),
                              prefixIconColor: Colors.deepPurple.shade500,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  if (value.length < 8) {
                                    error[1] = 'minimum';
                                  } else if (value.length > 30) {
                                    error[1] = 'maximum';
                                  } else {
                                    error[1] = '';
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        error[1] == ''
                            ? SizedBox(height: 39)
                            : SizedBox(height: 15),
                        SizedBox(
                          width: 600,
                          child: TextField(
                            controller: controllers[2],
                            key: Key('Location'),
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
                              errorText: error[2] == 'empty'
                                  ? 'Location Can\'t be empty'
                                  : error[2] == 'minimum'
                                      ? 'Minimum Limit is not Reached'
                                      : error[2] == 'maximum'
                                          ? 'Maximum Limit is Exceeded'
                                          : null,
                              prefixIcon: Icon(Icons.location_searching,
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
                                    error[2] = 'minimum';
                                  } else if (value.length > 40) {
                                    error[2] = 'maximum';
                                  } else {
                                    error[2] = '';
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        error[2] == ''
                            ? SizedBox(height: 39)
                            : SizedBox(height: 15),
                        Container(
                          width: 600,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 9),
                                  SizedBox(
                                      child: Icon(Icons.location_city,
                                          color: Colors.deepPurple[500])),
                                  SizedBox(width: 7),
                                  SizedBox(
                                    width: 100,
                                    child: Text('State City',
                                        style: TextStyle(
                                            color: Colors.deepPurple[500],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              CSCPicker(
                                dropdownHeadingStyle: TextStyle(
                                    color: Colors.deepPurple.shade500,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                dropdownItemStyle: TextStyle(
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 18,
                                ),
                                selectedItemStyle: TextStyle(
                                    color: Colors.deepPurple.shade500,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.zero),
                                    color: Colors.white,
                                    shape: BoxShape.rectangle),
                                disabledDropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.zero),
                                    color: Colors.white),
                                layout: Layout.vertical,
                                defaultCountry: CscCountry.India,
                                disableCountry: true,
                                onCountryChanged: (country) {},
                                onStateChanged: (value) {
                                  setState(() {
                                    controllers[4].text = value.toString();
                                  });
                                },
                                onCityChanged: (value) {
                                  setState(() {
                                    controllers[3].text = value.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        error[3] == 'empty'
                            ? Container(
                                width: 575,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'City Can\'t be unselected',
                                  style: TextStyle(
                                      color: Colors.red[700], fontSize: 12),
                                  textAlign: TextAlign.start,
                                ))
                            : error[4] == 'empty'
                                ? Container(
                                    width: 575,
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'State Can\'t be unselected',
                                      style: TextStyle(
                                          color: Colors.red[700], fontSize: 12),
                                      textAlign: TextAlign.start,
                                    ))
                                : SizedBox(height: 50),
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
                                    } else {
                                      error[i] = '';
                                    }
                                  }
                                  for (int i = 0; i < 5; i++) {
                                    if (controllers[i].text == '' ||
                                        error[i] != '') {
                                      valid = false;
                                    }
                                  }
                                });
                                for (int i = 0;
                                    i < BranchState.maindata.length;
                                    i++) {
                                  if (controllers[0].text ==
                                      BranchState.maindata[i]['BranchId']) {
                                    error[0] = 'already exist';
                                    valid = false;
                                    break;
                                  }
                                }
                                if (valid) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Map<String, dynamic> query = {
                                    'BranchId': controllers[0].text,
                                    'BranchName': controllers[1].text,
                                    'Location': controllers[2].text,
                                    'City': controllers[3].text,
                                    'State': controllers[4].text,
                                    'AddedBy': LoginState.manager
                                  };
                                  await DB.openCon('branch');
                                  await DB.collection.insertOne(query);
                                  await DB.closeCon();
                                  await DB.openCon('product');
                                  List<Map<String, dynamic>> product =
                                      await DB.collection.find().toList();
                                  List<String> productid = [];
                                  List<String> productname = [];
                                  for (int i = 0; i < product.length; i++) {
                                    productid.add(product[i]['ProductId']);
                                    productname.add(product[i]['ProductName']);
                                  }
                                  await DB.closeCon();
                                  await DB.openCon('stock');
                                  for (int i = 0; i < productid.length; i++) {
                                    query = {
                                      'ProductId': productid[i],
                                      'ProductName': productname[i],
                                      'BranchName': controllers[1].text,
                                      'Quantity': 0,
                                    };
                                    await DB.collection.insertOne(query);
                                  }
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
                                  controllers[4].clear();
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
