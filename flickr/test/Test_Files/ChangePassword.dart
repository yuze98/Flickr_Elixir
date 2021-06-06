// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  bool visibility;
  bool hiddenText;
  bool popUpMsg;
  String buttonText = 'Next';
  String email;
  String newPassword;
  bool oldBool;

  String validateNewPassword(String value) {
    Pattern pattern = r"^(?=.[A-Za-z])(?=.\d)[A-Za-z\d]{8,}$";
    RegExp regex = new RegExp(pattern);
    newPassword = value;
    if (!regex.hasMatch(value) || value == null) {
      oldBool = false;
      return 'Enter a valid Password (8 or more characters)';
    } else {
      oldBool = true;
      return null;
    }
  }

  group('Valid Changing password', () {
    test('value from true to false', () {
      newPassword = "0123456789aaa"; //12
      validateNewPassword(newPassword);
      expect(oldBool, false);
    });

    test('Valid Changing password', () {
      newPassword = "0123456789"; //10
      validateNewPassword(newPassword);
      expect(oldBool, true);
    });
  });
}
