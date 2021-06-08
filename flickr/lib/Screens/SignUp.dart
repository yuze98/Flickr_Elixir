import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flickr/api/RequestAndResponses.dart';

///Displays the sign up page presented when creating a new account.

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

bool fnameBool = false;
bool lnameBool = false;
bool ageBool = false;
bool emailBool = false;
bool pwBool = false;

//FB sign up
class _SignupState extends State<Signup> {
  @override
  void initState() {
    // TODO: implement initState
    fnameBool = false;
    lnameBool = false;
    ageBool = false;
    emailBool = false;
    pwBool = false;

    super.initState();
  }

  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  Future<Null> SingUpFB() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    int response = await FlickrRequestsAndResponses.signUpFB(facebookSignIn);

    //checks if the user is already sign up
    if (response == 201) {
      showAlertDialog(context, 'Signed up successfully');
    } else {
      showAlertDialog(context, 'User Exists');
      await facebookSignIn.logOut(); //user should
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Image.asset(
            'images/flickricon.png',
            scale: deviceSize.width * 0.03,
          ),
          title: Text(
            'flickr',
            style: TextStyle(
              fontSize: deviceSize.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: deviceSize.height * 0.15,
          actions: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              deviceSize.width * 0.01, 0, deviceSize.width * 0.01, 0),
          child: ListView(
            children: [
              SizedBox(
                height: 25.0,
              ),
              Image.asset(
                'images/flickricon.png',
                height: deviceSize.height * 0.04,
              ),
              Center(
                child: Text(
                  'Sign up for Flickr',
                  style: TextStyle(
                    fontSize: deviceSize.width * 0.06,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01,
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validateName,
                    controller: firstNameController,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'First name',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ), //first name
              Padding(
                padding: EdgeInsets.fromLTRB(
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01,
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validateName,
                    controller: secondNameController,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Second name',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ), // second name
              Padding(
                padding: EdgeInsets.fromLTRB(
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01,
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validateAge,
                    controller: ageController,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Your age',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ), //your age
              Padding(
                padding: EdgeInsets.fromLTRB(
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01,
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validateEmail,
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Email address',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ), //email address
              Padding(
                padding: EdgeInsets.fromLTRB(
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01,
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validatePassword,
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ), // password
              Padding(
                padding: EdgeInsets.fromLTRB(
                    deviceSize.width * 0.05,
                    deviceSize.height * 0.07,
                    deviceSize.width * 0.05,
                    deviceSize.height * 0.01),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red[600],
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    minimumSize: Size(deviceSize.width, deviceSize.height / 10),
                  ),
                  onPressed: () {
                    print(validateSubmit());
                    sending();
                    //Navigator.pop(context);
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        letterSpacing: deviceSize.width * 0.005,
                        fontWeight: FontWeight.bold,
                        fontSize: deviceSize.width * 0.06),
                  ),
                ),
              ), //submit button
              Center(
                heightFactor: deviceSize.height * 0.005,
                child: SizedBox(
                  child: Text(
                    "OR",
                    style: TextStyle(
                        fontSize: deviceSize.width * 0.04, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    deviceSize.width * 0.05,
                    deviceSize.height * 0.01,
                    deviceSize.width * 0.05,
                    deviceSize.height * 0.01),
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue[700],
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    minimumSize: Size(deviceSize.width, deviceSize.height / 10),
                  ),
                  onPressed: () {
                    SingUpFB();
                    Navigator.pushNamed(context, "LoginScreen");
                    //Add some functionalties to sign up for FB
                  },
                  icon: Image.asset(
                    "images/fb.png",
                    scale: deviceSize.width * 0.03,
                  ),
                  label: Text(
                    "Sign up with Facebook",
                    style: TextStyle(
                        letterSpacing: deviceSize.width * 0.005,
                        fontWeight: FontWeight.bold,
                        fontSize: deviceSize.width * 0.04),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01,
                    deviceSize.width * 0.06,
                    deviceSize.height * 0.01),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By signing up you agree with Flickr\'s ',
                        style: TextStyle(
                            fontSize: deviceSize.width * 0.035,
                            color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: 'Terms of Services ',
                        style: TextStyle(
                            fontSize: deviceSize.width * 0.035,
                            color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://www.flickr.com/help/terms');
                          },
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                            fontSize: deviceSize.width * 0.035,
                            color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(
                            fontSize: deviceSize.width * 0.035,
                            color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://www.flickr.com/help/privacy');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: deviceSize.height * 0.004,
              ),
              Text(
                'Already a Flickr member?',
                style: TextStyle(
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Log in here !",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.teal,
                      fontSize: deviceSize.width * 0.05),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  void sending() async {
    int response = await FlickrRequestsAndResponses.signUpRequests(
        context,
        passwordController,
        emailController,
        firstNameController,
        secondNameController,
        ageController);

    if (response == 201) {
      showAlertDialog(context, validateSubmit());
    } else {
      showAlertDialog(context, 'Enter valid parameters');
    }
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

String validateName(String value) {
  Pattern pattern = r"^[a-z A-Z]+$";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    fnameBool = false;
    lnameBool = false;
    return 'Enter a valid Name';
  } else {
    fnameBool = true;
    lnameBool = true;
    return null;
  }
}

String validateAge(String value) {
  Pattern pattern = r"^[1-9][0-9]?$";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    ageBool = false;
    return 'Enter a valid Age';
  } else {
    ageBool = true;
    return null;
  }
}

String validatePassword(String value) {
  Pattern pattern =
      r"^([0-9]|[A-Za-z])*(.*[A-Za-z]*)(?=.*\d*)[A-Za-z\d*]{12,}$";

  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    pwBool = false;
    return 'Enter a valid Password (12 or more characters)';
  } else {
    pwBool = true;
    return null;
  }
}

String validateSubmit() {
  String str;
  if (!pwBool || !ageBool || !fnameBool || !lnameBool || !emailBool) {
    str = 'Enter valid parameters';
  } else {
    str = 'Everything is ready';
  }
  return str;
}

showAlertDialog(BuildContext context, String str) {
  // Create button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      if (str == 'Everything is ready') {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
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
