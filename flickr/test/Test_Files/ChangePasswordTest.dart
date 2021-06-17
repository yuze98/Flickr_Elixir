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
  bool newBool = false;
  bool confirmBool = false;
  String newPassword;
  bool oldBool;
  String oldPassword;
  String confirmPassword;
  String str;

  void validateOldPassword(String value) {
    Pattern pattern =
        r"^([0-9]|[A-Za-z])*(.*[A-Za-z]*)(?=.*\d*)[A-Za-z\d*]{12,}$";

    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      oldBool = false;
    } else {
      oldBool = true;
    }
  }

  group('Old Password Validation', () {
    test('Valid Old password', () {
      oldPassword = "0123456789aaa"; //12
      validateOldPassword(oldPassword);
      expect(oldBool, true);
    });

    test('Invalid Old password', () {
      oldPassword = "0123456789"; //10
      validateOldPassword(oldPassword);
      expect(oldBool, false);
    });
  });

  void validateNewPassword(String value) {
    Pattern pattern =
        r"^([0-9]|[A-Za-z])*(.*[A-Za-z]*)(?=.*\d*)[A-Za-z\d*]{12,}$";

    RegExp regex = new RegExp(pattern);
    newPassword = value;
    if (!regex.hasMatch(value) || value == null) {
      oldBool = false;
    } else {
      oldBool = true;
    }
  }

  group('New password Validation', () {
    test('Valid New password', () {
      newPassword = "aaa0123456789"; //12
      validateNewPassword(newPassword);
      expect(oldBool, true);
    });

    test('Invalid New password', () {
      newPassword = "0123456789"; //10
      validateNewPassword(newPassword);
      expect(oldBool, false);
    });
  });

  String validateConfirmPassword(String value) {
    Pattern pattern =
        r"^([0-9]|[A-Za-z])*(.*[A-Za-z]*)(?=.*\d*)[A-Za-z\d*]{12,}$";

    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      oldBool = false;
      return 'Enter a valid Password (12 or more characters';
    } else if (value == oldPassword || newPassword == oldPassword) {
      oldBool = false;
      return "New Password can't be the old password";
    } else if (value != newPassword) {
      oldBool = false;
      return 'Unmatched Passwords! Enter it again';
    } else {
      oldBool = true;
      return null;
    }
  }

  group('Confirm Password Validation', () {
    test('Valid Confirmation password', () {
      oldPassword = "0123456789aaa";
      confirmPassword = "aaa0123456789";
      newPassword = "aaa0123456789";

      validateConfirmPassword(newPassword);
      expect(oldBool, true);
    });

    test('Invalid Confirmation password', () {
      oldPassword = "0123456789";
      confirmPassword = "0123456789";
      newPassword = "0123456789";
      validateConfirmPassword(newPassword);
      expect(oldBool, false);
    });
  });

  String validateConfirm() {
    if (!oldBool && !newBool && !confirmBool) {
      str = "Please enter valid parameters!";
    } else {
      str = "Password is changed successfully";
    }
    return str;
  }

  group('validate Confirm ', () {
    test('Valid Confirmation password', () {
      oldBool = true;
      newBool = true;
      confirmBool = true;

      validateConfirm();
      expect(str, "Password is changed successfully");
    });

    test('Invalid Confirmation password', () {
      oldBool = false;
      newBool = false;
      confirmBool = false;

      validateConfirm();
      expect(str, "Please enter valid parameters!");
    });
  });

  bool _selectionModel;
  bool isCleared;
  void changeSelection(bool enable, int index) {
    /// If true then _selectedIndexList is cleared
    isCleared = false;
    _selectionModel = enable;
    if (index == -1) {
      isCleared = true;
    }
  }

  group('Change Selection check ', () {
    test('index is -1, enable is true', () {
      changeSelection(true, -1);
      expect(_selectionModel, true);
      expect(isCleared, true);
    });

    test('index is -1, enable is false', () {
      changeSelection(false, -1);
      expect(_selectionModel, false);
      expect(isCleared, true);
    });

    test('index is not -1, enable is true', () {
      changeSelection(true, 0);
      expect(_selectionModel, true);
      expect(isCleared, false);
    });

    test('index is not -1, enable is false', () {
      changeSelection(false, 0);
      expect(_selectionModel, false);
      expect(isCleared, false);
    });
  });
}
