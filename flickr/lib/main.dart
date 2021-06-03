import 'dart:ffi';

import 'package:flickr/Essentials/LoadingScreen.dart';
import 'package:flickr/Screens/ChangePassword.dart';
import 'package:flickr/Screens/UploadDetails.dart';
import 'package:flutter/material.dart';
import 'Screens/LoginPage.dart';
import 'Screens/GetStarted.dart';
import 'Screens/SignUp.dart';
import 'Screens/SubProfile.dart';
import 'Screens/ForgetPass.dart';
import 'Screens/About.dart';
import 'Screens/UserPage.dart';
import 'package:flickr/Screens/Tags.dart';
import 'package:flickr/Screens/CameraRoll.dart';

import 'package:flutter_plugin_android_lifecycle/flutter_plugin_android_lifecycle.dart';
import 'Screens/SearchScreen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: 'GetStarted',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        'GetStarted': (context) => GetStarted(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        'LoginScreen': (context) => LoginScreen(),
        'UploadDetails': (context) => ImageDetails(),
        'Tags': (context) => Tags(),
        'signUp': (context) => Signup(),
        'UserPage': (context) => UserPage(),
        'CameraRoll': (context) => CameraRoll(),
        'about': (context) => AboutState(),
        'forgetPass': (context) => forgetPass(),
        'ChangePassword': (context) => ChangePassword(),
        'LoadingScreen': (context) => LoadingScreen(),
        'SearchPage': (context) => SearchScreen(),
      },
    ),
  );
}
