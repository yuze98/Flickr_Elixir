import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/RequestAndResponses.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  // This widget is the root of your application.
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmCodeController = TextEditingController();

  bool emailBool = false;
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
        //resizeToAvoidBottomInset: false, //new line

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Enter Your Email",
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
                    validator: validateEmail,
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(25),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintText: 'Email',
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
                      "Confirm Code",
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
                    controller: confirmCodeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(25),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintText: 'Confirm Code',
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
                      resetPassword();
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
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  String validateNewPassword(String value) {
    Pattern pattern =
        r"^([0-9]|[A-Za-z])*(.*[A-Za-z]*)(?=.*\d*)[A-Za-z\d*]{12,}$";

    RegExp regex = new RegExp(pattern);
    newPassword = value;
    if (!regex.hasMatch(value) || value == null) {
      newBool = false;
      return 'Enter a valid Password (12 or more characters)';
    } else {
      newBool = true;
      return null;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.toLowerCase()) || value == null) {
      emailBool = false;
      return 'Enter a valid email address';
    } else {
      emailBool = true;
      return null;
    }
  }

  String validateConfirm() {
    String str;

    if (!emailBool && !newBool && !confirmBool) {
      str = 'Please enter valid parameters!';
    } else {
      str = 'Password is changed successfully';
    }
    return str;
  }

  void resetPassword() async {
    if (validateConfirm() == 'Password is changed successfully') {
      var response = await FlickrRequestsAndResponses.resetPassword(
          emailController.text,
          newPasswordController.text,
          confirmCodeController.text);

      if (response.statusCode == 200) {
        print("Password is changed successfully");
        showAlertDialog(context, 'Password is changed successfully');
      } else {
        var body = json.decode(response.body);
        showAlertDialog(context, body["message"]);
      }
    } else {
      showAlertDialog(context, 'Enter Valid Parameters');
    }
  }

  showAlertDialog(BuildContext context, String str) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (str == 'Password is changed successfully') {
          Navigator.pushNamedAndRemoveUntil(
              context, "LoginScreen", (r) => false);
        } else {
          Navigator.pop(context);
        }
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
