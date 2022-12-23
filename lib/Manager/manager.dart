// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Manager extends StatefulWidget {
  Manager({Key? key}) : super(key: key);

  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  var managername = TextEditingController();
  int selectedvalue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Manager',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        SizedBox(height: 50),
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
                  value: 2, alignment: Alignment.center, child: Text('Name')),
              DropdownMenuItem(
                  value: 3,
                  alignment: Alignment.center,
                  child: Text('ManagerName')),
            ],
            onChanged: (value) {
              setState(() {
                selectedvalue = value!;
              });
            }),
        SizedBox(height: 50),
        selectedvalue == 2
            ? SizedBox(
                width: 750,
                child: TextField(
                  controller: managername,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '@Managers Name',
                    labelText: 'Name',
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
                ),
              )
            : selectedvalue == 3
                ? SizedBox(
                    width: 750,
                    child: TextField(
                      controller: managername,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '@ThereYouCome',
                        labelText: 'ManagerName',
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
                    ),
                  )
                : SizedBox(),
        SizedBox(height: 50),
        
      ],
    );
  }
}
