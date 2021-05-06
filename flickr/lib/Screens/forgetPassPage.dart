import 'package:flutter/material.dart';
import 'CheckInboxPage.dart';

class forgetPass extends StatefulWidget {
  @override
  _forgetPassState createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass> {
  TextEditingController emailController = TextEditingController();

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
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: 'Enter email',
                            fillColor: Colors.white,
                          ),
                          controller: emailController,
                          onSubmitted: (text) {
                            print(emailController.text);
                          },
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
                              print(emailController.text);
                              // sendMail(emailController.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      checkInbox(email: emailController.text),
                                ),
                                // print("Immm innnnnnnnnnnnnnnnnnnnnnnn");
                              );
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
}
