// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';

class Sales extends StatefulWidget {
  Sales({Key? key}) : super(key: key);

  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List<TextEditingController> controllers =
      List.generate(7, (index) => TextEditingController());
  List<String> error = ['', '', '', '', ''];
  bool valid = true;

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
                      if (EmailValidator.validate(controllers[3].text)) {
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
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '9876543210',
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.deepPurple.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    errorText: error[3] == 'empty'
                        ? 'Mobile Number Can\'t be empty'
                        : error[3] == 'minimum'
                            ? 'Minimum Limit is not Reached'
                            : error[3] == 'maximum'
                                ? 'Maximum Limit is Exceeded'
                                : error[3] == 'already exist'
                                    ? 'Branch Id already exist'
                                    : null,
                    prefixIcon:
                        Icon(Icons.phone, color: Colors.deepPurple.shade500),
                    prefixIconColor: Colors.deepPurple.shade500,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        if (value.length < 10) {
                          error[3] = 'minimum';
                        } else if (value.length > 10) {
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
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GFButton(
                onPressed: () async {},
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                text: 'Get OTP',
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
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 800,
          child: TextField(
            controller: controllers[4],
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: '549658',
              labelText: 'Enter OTP',
              labelStyle: TextStyle(
                  backgroundColor: Colors.white,
                  color: Colors.deepPurple.shade500,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              errorText: error[4] == 'empty'
                  ? 'OTP Can\'t be empty'
                  : error[4] == 'minimum'
                      ? 'Minimum Limit is not Reached'
                      : error[4] == 'maximum'
                          ? 'Maximum Limit is Exceeded'
                          : null,
              prefixIcon: Icon(Icons.phone, color: Colors.deepPurple.shade500),
              prefixIconColor: Colors.deepPurple.shade500,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(),
              ),
            ),
            onChanged: (value) {
              setState(() {
                if (value.isNotEmpty) {
                  if (value.length < 6) {
                    error[4] = 'minimum';
                  } else if (value.length > 6) {
                    error[4] = 'maximum';
                  } else {
                    error[4] = '';
                  }
                }
              });
            },
          ),
        ),
        error[4] == '' ? SizedBox(height: 34) : SizedBox(height: 10),
        GFButton(
          onPressed: () {
            controllers[5].text = 'No Product Selected';
            controllers[6].text = 'Unavailable';
          },
          icon: Icon(
            Icons.check,
            color: Colors.green,
          ),
          text: 'Submit OTP',
          textColor: Colors.white,
          color: Colors.deepPurple.shade700,
          hoverColor: Colors.deepPurple.shade500,
          shape: GFButtonShape.square,
          size: GFSize.LARGE,
        ),
        SizedBox(height: 34),
        Container(
          color: Colors.deepPurple.shade900,
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  controller: controllers[5],
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
                  controller: controllers[6],
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
                onPressed: () {},
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
        ),
        SizedBox(height: 30),
        GFButton(
          onPressed: () {},
          icon: Icon(
            Icons.check,
            color: Colors.green,
          ),
          text: 'Submit Order',
          textColor: Colors.white,
          color: Colors.deepPurple.shade700,
          hoverColor: Colors.deepPurple.shade500,
          shape: GFButtonShape.square,
          size: GFSize.LARGE,
        ),
      ],
    );
  }
}
