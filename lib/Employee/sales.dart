// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unnecessary_new, avoid_print, import_of_legacy_library_into_null_safe, prefer_const_declarations

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Employee/Add/addsales.dart';
import 'package:sadms/Login/login.dart';

class Sales extends StatefulWidget {
  Sales({Key? key}) : super(key: key);

  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<String> error = ['', '', '', '', ''];
  bool valid = true;
  bool btn1 = false;
  bool btn2 = false;

  Future sendEmail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_hxy449r";
    const templateId = "template_mlpo2cb";
    const userId = "uHPLeAfO4E1R5eQgR";
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'name': controllers[0].text,
            'user': controllers[2].text
          }
        }));
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Sales',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        SizedBox(height: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: controllers[0],
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Durvesh More',
                        labelText: 'Customer\'s Name',
                        labelStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.deepPurple.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        errorText: error[0] == 'empty'
                            ? 'Customer\'s Name Can\'t be empty'
                            : error[0] == 'minimum'
                                ? 'Minimum Limit is not Reached'
                                : error[0] == 'maximum'
                                    ? 'Maximum Limit is Exceeded'
                                    : error[0] == 'already exist'
                                        ? 'Branch Id already exist'
                                        : null,
                        prefixIcon: Icon(Icons.person,
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
                              error[0] = 'minimum';
                            } else if (value.length > 30) {
                              error[0] = 'maximum';
                            } else {
                              error[0] = '';
                            }
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: controllers[1],
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ], // Only numbers can be entered
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '1234567890',
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.deepPurple.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        errorText: error[1] == 'empty'
                            ? 'Mobile Number Can\'t be empty'
                            : error[1] == 'invalid'
                                ? 'Enter a 10 digit Mobile Number'
                                : null,
                        prefixIcon: Icon(Icons.phone,
                            color: Colors.deepPurple.shade500),
                        prefixIconColor: Colors.deepPurple.shade500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.length < 10 || value.length > 10) {
                            error[1] = 'invalid';
                          } else {
                            error[1] = '';
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 500,
                child: TextField(
                  controller: controllers[2],
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'something@gmail.com',
                    labelText: 'E-mail Id',
                    labelStyle: TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.deepPurple.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    errorText: error[2] == 'empty'
                        ? 'Email Id Can\'t be empty'
                        : error[2] == 'invalid'
                            ? 'Invalid Email Id'
                            : null,
                    prefixIcon:
                        Icon(Icons.email, color: Colors.deepPurple.shade500),
                    prefixIconColor: Colors.deepPurple.shade500,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (EmailValidator.validate(controllers[2].text)) {
                        error[2] = '';
                      } else {
                        error[2] = 'invalid';
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: controllers[3],
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ], // Only numbers can be entered
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '400604',
                    labelText: 'Pincode',
                    labelStyle: TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.deepPurple.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    errorText: error[3] == 'empty'
                        ? 'Pincode Can\'t be empty'
                        : error[3] == 'minimum'
                            ? 'Minimum Limit is not Reached'
                            : error[3] == 'maximum'
                                ? 'Maximum Limit is Exceeded'
                                : null,
                    prefixIcon:
                        Icon(Icons.code, color: Colors.deepPurple.shade500),
                    prefixIconColor: Colors.deepPurple.shade500,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        if (value.length < 6) {
                          error[3] = 'minimum';
                        } else if (value.length > 6) {
                          error[3] = 'maximum';
                        } else {
                          error[3] = '';
                        }
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 50),
        GFButton(
          onPressed: () {
            setState(() {
              controllers[4].text = 'No Product Selected';
              controllers[5].text = 'Not Calculated';
              btn1 = true;
            });
          },
          icon: Icon(
            Icons.check,
            color: Colors.green,
          ),
          text: 'Create Order',
          textColor: Colors.white,
          color: Colors.deepPurple.shade700,
          hoverColor: Colors.deepPurple.shade500,
          shape: GFButtonShape.square,
          size: GFSize.LARGE,
        ),
        SizedBox(height: 50),
        btn1 == true
            ? Container(
                color: Colors.deepPurple.shade900,
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: controllers[4],
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Quantity',
                          labelStyle: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.deepPurple.shade500,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          prefixIcon: Icon(Icons.production_quantity_limits,
                              color: Colors.deepPurple.shade500),
                          prefixIconColor: Colors.deepPurple.shade500,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: controllers[5],
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Total Price',
                          labelStyle: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.deepPurple.shade500,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          prefixIcon: Icon(Icons.price_change,
                              color: Colors.deepPurple.shade500),
                          prefixIconColor: Colors.deepPurple.shade500,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    GFButton(
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => AddSales())))
                            .whenComplete(() {
                          setState(() {
                            controllers[4].text =
                                AddSalesState.total[0].toString();
                            controllers[5].text =
                                AddSalesState.total[1].toString();
                            btn2 = true;
                          });
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      text: 'Modify',
                      textColor: Colors.white,
                      color: Colors.deepPurple.shade700,
                      hoverColor: Colors.deepPurple.shade500,
                      shape: GFButtonShape.square,
                      size: GFSize.LARGE,
                    ),
                  ],
                ),
              )
            : SizedBox(),
        SizedBox(height: 50),
        btn2 == true
            ? GFButton(
                onPressed: () async {
                  await DB.openCon('sales');
                  await DB.collection.insertOne({
                    'CustomerName': controllers[0].text,
                    'Phone': controllers[1].text,
                    'EmailId': controllers[2].text,
                    'Products': AddSalesState.order,
                    'TotalQuantity': AddSalesState.total[0],
                    'TotalPrice': AddSalesState.total[1],
                    'SaleBy': LoginState.employee,
                    'Date': DateTime.now()
                  });
                  await DB.closeCon();
                  await DB.openCon('stock');
                  await DB.closeCon();
                  for (int i = 0; i <= 5; i++) {
                    controllers[i].clear();
                  }
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                text: 'Complete Purchase',
                textColor: Colors.white,
                color: Colors.deepPurple.shade700,
                hoverColor: Colors.deepPurple.shade500,
                shape: GFButtonShape.square,
                size: GFSize.LARGE,
              )
            : SizedBox(),
      ],
    );
  }
}
