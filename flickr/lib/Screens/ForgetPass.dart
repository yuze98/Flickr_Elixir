import 'dart:convert';

import 'package:flutter/material.dart';
import 'CheckInboxPage.dart';
import 'package:http/http.dart' as http;
import 'package:flickr/api/RequestAndResponses.dart';

/// This screen allows you to send an email to change your password
/// @receivedEmailController : is the email written at the [LoginScreen] if written
/// If email is valid it sends you an email to change password and sends you to [checkInbox] screen

class ForgetPass extends StatefulWidget {
  ForgetPass({this.receivedEmailController});

  final receivedEmailController;

  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = widget.receivedEmailController;
  }

  final EmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        // child: Padding(
                        //   padding: const EdgeInsets.only(left: 230),
                        child: Icon(
                          Icons.lock_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                        // ),
                      ),
                      TextSpan(
                        text: '\n\nForgot your password?',
                        style: TextStyle(
                            fontSize: devicesize.width * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text:
                            '\n\n Please enter your email address below and we\'ll send you instructions on how to reset your password.',
                        style: TextStyle(
                            fontSize: devicesize.width * 0.05,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                //Please enter your email address below and we'll send you instructions on how to reset your password.
                SizedBox(
                  height: devicesize.width * .08,
                  width: devicesize.width * .8,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 30.0, top: 30.0, right: 30.0),
                  // height: 40.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Form(
                          child: TextFormField(
                            controller: EmailController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(),
                              hintText: 'Enter email',
                              fillColor: Colors.white,
                            ),
                            onFieldSubmitted: (text) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            // textColor: Colors.white,
                            child: Text(
                              'Send email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: devicesize.width * 0.05,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            onPressed: () {
                              // setState(() {
                              //
                              // sendMail(emailController.text);
                              forgetPass(EmailController.text);
                              // };
                              //The user picked true.
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateSubmit(int value) {
    String str;

    if (value != 200) {
      str = 'Enter valid parameters';
    } else {
      str = 'Check your email';
    }
    return str;
  }

  void forgetPass(String email) async {
    var response = await FlickrRequestsAndResponses.forgetPass(email);

    if (response.statusCode == 200) {
      showAlertDialog(context, validateSubmit(200));
      Navigator.pushNamed(context, 'ResetPassword');
    } else {
      showAlertDialog(context, jsonDecode(response.body)["message"]);
    }
  }

  showAlertDialog(BuildContext context, String str) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (str == 'Check your email') {
          // Navigator.pushNamed(context, "UserPage1");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => checkInbox(email: EmailController.text),
            ),
          );
        } else
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
