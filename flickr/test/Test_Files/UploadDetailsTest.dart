import 'package:flutter_test/flutter_test.dart';

void main() {
  bool descriptionBool, titleBool;
  String description, title, str;

  String validateTitle(String value) {
    Pattern pattern = r"^[a-z A-Z]+$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      descriptionBool = false;
      titleBool = false;
      return 'Enter a valid Title';
    } else {
      descriptionBool = true;
      titleBool = true;
      return null;
    }
  }

  group('Title Validation', () {
    test('Valid Title', () {
      title = "Sunny Day";
      validateTitle(title);
      expect(descriptionBool, true);
      expect(titleBool, true);
    });

    test('InValid Title', () {
      title = "0123456789";
      validateTitle(title);
      expect(descriptionBool, false);
      expect(titleBool, false);
    });
  });

  String validateConfirm() {
    if (!descriptionBool || !titleBool) {
      str = 'Please enter valid parameters!';
    } else {
      str = 'done';
    }
    return str;
  }

  group('Confirm Validation', () {
    test('Valid Upload', () {
      descriptionBool = false;
      titleBool = false;
      validateConfirm();
      expect(str, 'Please enter valid parameters!');
    });

    test('Empty Upload', () {
      descriptionBool = true;
      titleBool = true;
      validateConfirm();
      expect(str, 'done');
    });
  });

  String validateDescription(String value) {
    Pattern pattern = r"^[a-z A-Z]+$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid Description';
    } else {
      return null;
    }
  }

  group('Description Validation', () {
    test('Valid Description', () {
      description = "It was a nice day";

      expect(validateDescription(description), null);
    });

    test('InValid Description', () {
      description = "0123456789";

      expect(validateDescription(description), 'Enter a valid Description');
    });
  });
}
