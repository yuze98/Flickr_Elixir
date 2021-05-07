import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

bool fnamebool = false;
bool lnamebool = false;
bool agebool = false;
bool emailbool = false;
bool pwbool = false;

//FB sign up
class _SignupState extends State<Signup> {
  @override
  void initState() {
    // TODO: implement initState
    fnamebool = false;
    lnamebool = false;
    agebool = false;
    emailbool = false;
    pwbool = false;

    super.initState();
  }

  final firstnameController = TextEditingController();
  final secondnameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _login() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        await facebookSignIn.logOut();
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Image.asset(
            'images/flickricon.png',
            scale: devicesize.width * 0.03,
          ),
          title: Text(
            'flickr',
            style: TextStyle(
              fontSize: devicesize.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: devicesize.height * 0.15,
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
              devicesize.width * 0.01, 0, devicesize.width * 0.01, 0),
          child: ListView(
            children: [
              SizedBox(
                height: 25.0,
              ),
              Image.asset(
                'images/flickricon.png',
                height: devicesize.height * 0.04,
              ),
              Center(
                child: Text(
                  'Sign up for Flickr',
                  style: TextStyle(
                    fontSize: devicesize.width * 0.06,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validatename,
                    controller: firstnameController,
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
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validatename,
                    controller: secondnameController,
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
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validateage,
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
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
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
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validatepassword,
                    controller: passwordController,
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
                    devicesize.width * 0.05,
                    devicesize.height * 0.07,
                    devicesize.width * 0.05,
                    devicesize.height * 0.01),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red[600],
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    minimumSize: Size(devicesize.width, devicesize.height / 10),
                  ),
                  onPressed: () {
                    print(firstnameController.text);
                    print(secondnameController.text);
                    print(ageController.text);
                    print(emailController.text);
                    print(passwordController.text);

                    print(pwbool);
                    print(emailbool);

                    print(validateubmit());
                    sending();
                    //Navigator.pop(context);
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        letterSpacing: devicesize.width * 0.005,
                        fontWeight: FontWeight.bold,
                        fontSize: devicesize.width * 0.06),
                  ),
                ),
              ), //submit button
              Center(
                heightFactor: devicesize.height * 0.005,
                child: SizedBox(
                  child: Text(
                    "OR",
                    style: TextStyle(
                        fontSize: devicesize.width * 0.04, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    devicesize.width * 0.05,
                    devicesize.height * 0.01,
                    devicesize.width * 0.05,
                    devicesize.height * 0.01),
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue[700],
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    minimumSize: Size(devicesize.width, devicesize.height / 10),
                  ),
                  onPressed: () {
                    _login();
                    Navigator.pushNamed(context, "LoginScreen");
                    //Add some functionalties to sign up for FB
                  },
                  icon: Image.asset(
                    "images/fb.png",
                    scale: devicesize.width * 0.03,
                  ),
                  label: Text(
                    "Sign up with Facebook",
                    style: TextStyle(
                        letterSpacing: devicesize.width * 0.005,
                        fontWeight: FontWeight.bold,
                        fontSize: devicesize.width * 0.04),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By signing up you agree with Flickr\'s ',
                        style: TextStyle(
                            fontSize: devicesize.width * 0.035,
                            color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: 'Terms of Services ',
                        style: TextStyle(
                            fontSize: devicesize.width * 0.035,
                            color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://www.flickr.com/help/terms');
                          },
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                            fontSize: devicesize.width * 0.035,
                            color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(
                            fontSize: devicesize.width * 0.035,
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
                thickness: devicesize.height * 0.004,
              ),
              Text(
                'Already a Flickr member?',
                style: TextStyle(
                  fontSize: devicesize.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'LoginScreen');
                },
                child: Text(
                  "Log in here !",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.teal,
                      fontSize: devicesize.width * 0.05),
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
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io//register/signUp?email=${emailController.text}&password=${passwordController.text}&firstname=${firstnameController.text}&lastname=${secondnameController.text}&age=${ageController.text}';

    var response = await http.post(
      Uri.parse(url),
      body: {
        "email": "${emailController.text}",
        "password": "${passwordController.text}",
        "firstName": "${firstnameController.text}",
        "lastName": "${secondnameController.text}",
        "age": "${ageController.text}",
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      showAlertDialog(context, validateubmit());
    } else {
      showAlertDialog(context, 'Enter valid parameters');
    }
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    emailbool = false;
    return 'Enter a valid email address';
  } else {
    emailbool = true;
    return null;
  }
}

String validatename(String value) {
  Pattern pattern = r"^[a-z A-Z]+$";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    fnamebool = false;
    lnamebool = false;
    return 'Enter a valid Name';
  } else {
    fnamebool = true;
    lnamebool = true;
    return null;
  }
}

String validateage(String value) {
  Pattern pattern = r"^[1-9][0-9]?$";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    agebool = false;
    return 'Enter a valid Age';
  } else {
    agebool = true;
    return null;
  }
}

String validatepassword(String value) {
  Pattern pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    pwbool = false;
    return 'Enter a valid Password (8 or more characters)';
  } else {
    pwbool = true;
    return null;
  }
}

String validateubmit() {
  String str;
  if (!pwbool || !agebool || !fnamebool || !lnamebool || !emailbool) {
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
        Navigator.pushNamed(context, "UserPage");
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
