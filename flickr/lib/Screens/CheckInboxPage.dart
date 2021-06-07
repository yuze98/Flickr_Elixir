import 'package:flutter/material.dart';
import 'LoginPage.dart';

class checkInbox extends StatelessWidget {
  final String email;
  checkInbox({Key key, @required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
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
                            Icons.mail,
                            size: 30,
                            color: Colors.grey,
                          ),
                          // ),
                        ),
                        TextSpan(
                          text: '\n\nCheck your Inbox',
                          style: TextStyle(
                              fontSize: devicesize.width * 0.07,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                        TextSpan(
                          text: '\n\n We sent a verification link to ',
                          style: TextStyle(
                              fontSize: devicesize.width * 0.05,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: email,
                          style: TextStyle(
                              fontSize: devicesize.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text:
                              '. Please check your email to reset your password.',
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
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              // textColor: Colors.white,
                              child: Text(
                                'Resend email',
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

                                // sendMail(emailController.text);
                                Navigator.pop(context, LoginScreen());
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
      ),
    );
  }
}
