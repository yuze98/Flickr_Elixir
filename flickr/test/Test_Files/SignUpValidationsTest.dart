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
  String email;
  String newPassword;
  String name;
  bool emailBool;
  bool fnameBool;
  bool lnameBool;
  bool ageBool;
  int age;
  String str;

  void validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.toLowerCase()) || value == null) {
      emailBool = false;
    } else {
      emailBool = true;
    }
  }

  void validateName(String value) {
    Pattern pattern = r"^[a-z A-Z]+$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      fnameBool = false;
      lnameBool = false;
    } else {
      fnameBool = true;
      lnameBool = true;
    }
  }

  void validateAge(String value) {
    Pattern pattern = r"^[1-9][0-9]?$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      ageBool = false;
    } else {
      ageBool = true;
    }
  }

  void validateSubmit() {
    if (!ageBool || !fnameBool || !lnameBool || !emailBool) {
      str = 'Enter valid parameters';
    } else {
      str = 'Everything is ready';
    }
  }

  group('Validating email', () {
    test('value from true to false', () {
      email = "ast_emo@hotmail.com"; //12
      validateEmail(email);
      expect(emailBool, true);
    });

    test('InValid', () {
      email = "t"; //10
      validateEmail(email);
      expect(emailBool, false);
    });
  });

  group('Validating names', () {
    test('value from true to false', () {
      name = "Tarek"; //12
      validateName(name);
      expect(fnameBool, true);
      expect(lnameBool, true);
    });

    test('InValid', () {
      name = "123"; //10
      validateName(name);
      expect(fnameBool, false);
      expect(lnameBool, false);
    });
  });

  group('Validating Age', () {
    test('value from true to false', () {
      age = 12; //12
      validateAge(age.toString());
      expect(ageBool, true);
    });

    test('InValid', () {
      age = 123; //12
      validateAge(age.toString());
      expect(ageBool, false);
    });
  });

  group('Validating Submit', () {
    test('value from true to false', () {
      ageBool = true;
      fnameBool = true;
      lnameBool = true;
      emailBool = true;
      validateSubmit();
      expect(str, 'Everything is ready');
    });

    test('InValid', () {
      ageBool = false;
      validateSubmit();
      expect(str, 'Enter valid parameters');
    });
  });
}
