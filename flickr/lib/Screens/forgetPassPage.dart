import 'package:flutter/material.dart';
import 'CheckInboxPage.dart';
import 'package:http/http.dart' as http;

class forgetPass extends StatefulWidget {
  forgetPass({this.receivedEmailController});

  final receivedEmailController;

  @override
  _forgetPassState createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass> {
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
                            onFieldSubmitted: (text) {
                              sending();
                              print(emailController.text);
                            },
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

  String validateubmit(int value) {
    String str;
    if (value != 200) {
      str = 'Enter valid parameters';
    } else {
      str = 'Check your email';
    }
    return str;
  }

  void sending() async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io//register/forgetPassword?email=${EmailController.text}';

    var response = await http.get(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      showAlertDialog(context, validateubmit(200));
    } else {
      showAlertDialog(context, 'Enter valid parameters');
    }
  }

  showAlertDialog(BuildContext context, String str) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (str == 'Check your email')
          Navigator.pushNamed(context, "UserPage1");
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
