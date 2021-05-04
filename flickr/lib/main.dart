import 'package:flutter/material.dart';
import 'Screens/Login_page.dart';
import 'Screens/GetStarted.dart';
import 'Screens/SignUp.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: 'GetStarted',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        'GetStarted': (context) => GetStarted(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        'LoginScreen': (context) => LoginScreen(),
        'Signup': (context) => Signup(),
      },
    ),
  );
}
