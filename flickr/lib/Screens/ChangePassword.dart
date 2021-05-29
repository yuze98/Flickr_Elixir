import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/RequestAndResponses.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  // This widget is the root of your application.
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final confirmPassword = TextEditingController();
  bool oldBool = false;
  bool newBool = false;
  bool confirmBool = false;
  var newPassword;

  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
        resizeToAvoidBottomInset: false, //new line

        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Image.asset('images/flickricon.png'),
          title: Text(
            'Change Password ',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: deviceSizeheight * .1,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Enter old Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSizewidth * .9,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: validateOldPassword,
                  controller: oldPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(25),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: 'Old Password',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Enter New Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSizewidth * .9,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: validateNewPassword,
                  controller: newPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(25),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: 'New Password',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Confirm Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSizewidth * .9,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: validateConfirmPassword,
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(25),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: 'Confirm Password',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceSizeheight * .15),
              child: Container(
                width: deviceSizewidth * .8,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(deviceSizewidth * .5),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
//                      primary:
                    changePassword();
                    //                    Colors.deepOrange;
                    print('Pressed');
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  String validateOldPassword(String value) {
    Pattern pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      oldBool = false;
      return 'Enter a valid Password (8 or more characters)';
    } else {
      oldBool = true;
      return null;
    }
  }

  String validateNewPassword(String value) {
    Pattern pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
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

  String validateConfirmPassword(String value) {
    Pattern pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      oldBool = false;
      return 'Enter a valid Password (8 or more characters)';
    } else if (value == oldPasswordController.text ||
        newPassword == oldPasswordController.text) {
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

  String validateConfirm() {
    String str;
    if (!oldBool && !newBool && !confirmBool) {
      str = 'Please enter valid parameters!';
    } else {
      str = 'Password is changed successfully';
    }
    return str;
  }

  void changePassword() async {
    int statusCode = await FlickrRequestsAndResponses.changePassword(
        newPasswordController, oldPasswordController);
    if (statusCode == 200) {
      showAlertDialog(context, validateConfirm());
    } else {
      showAlertDialog(context, 'Enter valid parameters');
    }
  }

  showAlertDialog(BuildContext context, String str) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (str == 'Password is changed successfully')
          Navigator.pushNamedAndRemoveUntil(context, "UserPage", (r) => false);
        else
          Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(str),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
