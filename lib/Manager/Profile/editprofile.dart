// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sadms/Database/database.dart';
import 'package:sadms/Login/login.dart';
import 'package:sadms/Manager/Profile/Change/changeemailid.dart';
import 'package:sadms/Manager/Profile/Change/changepassword.dart';
import 'package:sadms/Manager/Profile/Change/changeusername.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());
  List<Map<String, dynamic>> manager = [];

  void getData() async {
    await DB.openCon('managerlogin');
    manager =
        await DB.collection.find({'Username': LoginState.manager}).toList();
    await DB.closeCon();
    controllers[0].text = manager[0]['Username'];
    controllers[1].text = manager[0]['EmailId'];
    controllers[2].text = manager[0]['Password'];
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[400],
        body: SizedBox(
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
                        'Edit Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: 750,
                    child: TextField(
                      controller: controllers[0],
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.deepPurple.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.text_format_outlined,
                            color: Colors.deepPurple.shade500),
                        prefixIconColor: Colors.deepPurple.shade500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 750,
                    child: TextField(
                      controller: controllers[1],
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Email Id',
                        labelStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.deepPurple.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.email,
                            color: Colors.deepPurple.shade500),
                        prefixIconColor: Colors.deepPurple.shade500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 750,
                    child: TextField(
                      controller: controllers[2],
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            backgroundColor: Colors.white,
                            color: Colors.deepPurple.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.lock_outlined,
                            color: Colors.deepPurple.shade500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: 750,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GFButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ChangeUsername())));
                          },
                          icon: Icon(
                            Icons.text_format_outlined,
                            color: Colors.white,
                          ),
                          text: 'Change Username',
                          textColor: Colors.white,
                          color: Colors.deepPurple.shade700,
                          hoverColor: Colors.deepPurple.shade500,
                          shape: GFButtonShape.square,
                          size: GFSize.LARGE,
                        ),
                        GFButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ChangeEmailId())));
                          },
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          text: 'Change Email Id',
                          textColor: Colors.white,
                          color: Colors.deepPurple.shade700,
                          hoverColor: Colors.deepPurple.shade500,
                          shape: GFButtonShape.square,
                          size: GFSize.LARGE,
                        ),
                        GFButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ChangePassword())));
                          },
                          icon: Icon(
                            Icons.lock_outlined,
                            color: Colors.white,
                          ),
                          text: 'Change Password',
                          textColor: Colors.white,
                          color: Colors.deepPurple.shade700,
                          hoverColor: Colors.deepPurple.shade500,
                          shape: GFButtonShape.square,
                          size: GFSize.LARGE,
                        ),
                      ],
                    ),
                  ),
                ])));
  }
}
