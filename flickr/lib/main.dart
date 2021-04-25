import 'package:flutter/material.dart';
import 'Screens/Login_page.dart';
import 'Screens/GetStarted.dart';
import 'Screens/SignUp.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => GetStarted(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => LoginScreen(),
        '/third': (context) => Signup(),
      },
    ),
  );
}
