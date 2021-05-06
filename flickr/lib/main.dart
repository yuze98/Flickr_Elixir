import 'package:flutter/material.dart';
import 'Screens/Login_page.dart';
import 'Screens/GetStarted.dart';
import 'Screens/SignUp.dart';
import 'Screens/UserPage.dart';
import 'Screens/ChangePassword.dart';
import 'Screens/UploadImage.dart';


void main() {
  runApp(UserPage1()
    // MaterialApp(
    //   initialRoute: '/',
    //   routes: {
    //     // When navigating to the "/" route, build the FirstScreen widget.
    //     '/': (context) => GetStarted(),
    //     // When navigating to the "/second" route, build the SecondScreen widget.
    //     '/second': (context) => LoginScreen(),
    //     //'/third': (context) => Signup(),
    //   },
    // ),
  );
}
