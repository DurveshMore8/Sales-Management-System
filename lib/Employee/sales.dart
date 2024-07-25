// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unnecessary_new, avoid_print, import_of_legacy_library_into_null_safe, prefer_const_declarations

import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sales_management_system/Database/database.dart';
import 'package:sales_management_system/Employee/Add/addsales.dart';
import 'package:sales_management_system/Login/login.dart';

class Sales extends StatefulWidget {
  Sales({Key? key}) : super(key: key);

  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  List<String> error = ['', '', '', '', ''];
  List<Map<String, dynamic>> branch = [];
  bool isLoading = true;
  bool isValid = true;
  bool btn1 = false;
  bool btn2 = false;

  Future sendEmail() async {
    String order = '';
    for (int i = 0; i < AddSalesState.order.length; i++) {
      order += '\nProduct ${i + 1}:';
      order += '\nName: ${AddSalesState.order[i]['ProductName']}';
      order += '\nQuantity: ${AddSalesState.order[i]['Quantity']}';
      order += '\nPrice: ${AddSalesState.order[i]['Price']}\n';
    }
    order += '\nTotal Quantity: ${AddSalesState.total[0]}';
    order += '\nTotal Price: ${AddSalesState.total[1]}\n';
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
            'user': controllers[2].text,
            'order': order
          }
        }));
    return response.statusCode;
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await DB.openCon('employeeinfo');
    branch =
        await DB.collection.find({'Username': LoginState.employee}).toList();
    await DB.closeCon();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    AddSalesState.order.clear();
    AddSalesState.total = [0, 0];
    super.initState();
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
                                key: Key('Customer'),
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
                                        btn1 = false;
                                        btn2 = false;
                                      } else if (value.length > 30) {
                                        error[0] = 'maximum';
                                        btn1 = false;
                                        btn2 = false;
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
                                key: Key('Mobile'),
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
                                    if (value.length < 10 ||
                                        value.length > 10) {
                                      error[1] = 'invalid';
                                      btn1 = false;
                                      btn2 = false;
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
                          width: 700,
                          child: TextField(
                            controller: controllers[2],
                            key: Key('EmailId'),
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
                              prefixIcon: Icon(Icons.email,
                                  color: Colors.deepPurple.shade500),
                              prefixIconColor: Colors.deepPurple.shade500,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (EmailValidator.validate(
                                    controllers[2].text)) {
                                  error[2] = '';
                                } else {
                                  error[2] = 'invalid';
                                  btn1 = false;
                                  btn2 = false;
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
                        isValid = true;
                        for (int i = 0; i < 3; i++) {
                          if (controllers[i].text.isEmpty) {
                            error[i] = 'empty';
                          }
                        }
                        for (int i = 0; i < 3; i++) {
                          if (error[i] != '') {
                            isValid = false;
                          }
                        }
                        if (isValid) {
                          controllers[3].text = 'No Product Selected';
                          controllers[4].text = 'Not Calculated';
                          btn1 = true;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    text: 'Create Order',
                    key: Key('Create'),
                    textColor: Colors.white,
                    color: Colors.deepPurple.shade700,
                    hoverColor: Colors.deepPurple.shade500,
                    shape: GFButtonShape.square,
                    size: GFSize.LARGE,
                  ),
                  SizedBox(height: 50),
                  btn1 == true
                      ? SizedBox(
                          height: 75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 400,
                                child: TextField(
                                  controller: controllers[3],
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
                                    prefixIcon: Icon(
                                        Icons.production_quantity_limits,
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
                                  controller: controllers[4],
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
                                          builder: ((context) =>
                                              AddSales()))).whenComplete(() {
                                    setState(() {
                                      if (AddSalesState.total[0] != 0 &&
                                          AddSalesState.total[1] != 0) {
                                        controllers[3].text =
                                            AddSalesState.total[0].toString();
                                        controllers[4].text =
                                            AddSalesState.total[1].toString();
                                        btn2 = true;
                                      } else {
                                        btn2 = false;
                                        controllers[3].clear();
                                        controllers[4].clear();
                                      }
                                    });
                                  });
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                text: 'Modify',
                                key: Key('Modify'),
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
                            setState(() {
                              isLoading = true;
                            });
                            await DB.openCon('sales');
                            await DB.collection.insertOne({
                              'CustomerName': controllers[0].text,
                              'Phone': controllers[1].text,
                              'EmailId': controllers[2].text,
                              'Products': AddSalesState.order,
                              'TotalQuantity': AddSalesState.total[0],
                              'TotalPrice': AddSalesState.total[1],
                              'SaleBy': LoginState.employee,
                              'BranchName': branch[0]['BranchName'],
                              'Date': DateTime(DateTime.now().year,
                                      DateTime.now().month, DateTime.now().day)
                                  .toString()
                                  .replaceAll(" 00:00:00.000", "")
                            });
                            List<Map<String, dynamic>> sale =
                                await DB.collection.find({
                              'CustomerName': controllers[0].text,
                              'Phone': controllers[1].text,
                              'EmailId': controllers[2].text,
                              'Products': AddSalesState.order,
                              'TotalQuantity': AddSalesState.total[0],
                              'TotalPrice': AddSalesState.total[1],
                              'SaleBy': LoginState.employee,
                              'BranchName': branch[0]['BranchName'],
                              'Date': DateTime(DateTime.now().year,
                                      DateTime.now().month, DateTime.now().day)
                                  .toString()
                                  .replaceAll(" 00:00:00.000", "")
                            }).toList();
                            await DB.closeCon();
                            await DB.openCon('productsales');
                            for (int i = 0;
                                i < AddSalesState.order.length;
                                i++) {
                              await DB.collection.insertOne({
                                'OrderId': sale[0]['_id'],
                                'CustomerName': controllers[0].text,
                                'Phone': controllers[1].text,
                                'EmailId': controllers[2].text,
                                'ProductName': AddSalesState.order[i]
                                    ['ProductName'],
                                'Quantity': AddSalesState.order[i]['Quantity'],
                                'Price': AddSalesState.order[i]['Price'],
                                'Date': DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day)
                                    .toString()
                                    .replaceAll(" 00:00:00.000", "")
                              });
                            }
                            await DB.closeCon();
                            await DB.openCon('stock');
                            for (int i = 0;
                                i < AddSalesState.order.length;
                                i++) {
                              List<Map<String, dynamic>> data =
                                  await DB.collection.find({
                                'ProductName': AddSalesState.order[i]
                                    ['ProductName'],
                                'BranchName': branch[0]['BranchName']
                              }).toList();
                              DB.updatestock(
                                  data,
                                  data[0]['Quantity'] -
                                      int.parse(
                                          AddSalesState.order[i]['Quantity']));
                            }
                            await DB.closeCon();
                            sendEmail();
                            setState(() {
                              isLoading = false;
                              for (int i = 0; i <= 4; i++) {
                                controllers[i].clear();
                              }
                              AddSalesState.order.clear();
                              AddSalesState.total = [0, 0];
                              btn1 = false;
                              btn2 = false;
                            });
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          text: 'Complete Purchase',
                          key: Key('Complete'),
                          textColor: Colors.white,
                          color: Colors.deepPurple.shade700,
                          hoverColor: Colors.deepPurple.shade500,
                          shape: GFButtonShape.square,
                          size: GFSize.LARGE,
                        )
                      : SizedBox(),
                ],
              ));
  }
}
