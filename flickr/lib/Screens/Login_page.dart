// import 'dart:html';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SignUp.dart';
import 'package:flutter/services.dart';
import 'forgetPassPage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'CommonVars.dart';
import 'RequestAndResponses.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

bool passwordCheck = false;
bool emailCheck = false;

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = false;

  void previewPassword() {
    if (emailCheck) {
      setState(() {
        showPassword = !showPassword;
      });
    } // Don't forget the else
  }

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
        //sending access token to our server
        var url =
            'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io//register/signUpWithFacebook?loginType=Facebook&accessToken=$accessToken';

        var response = await http.post(
          Uri.parse(url),
          body: {
            "loginType": "Facebook",
            "accessToken": "$accessToken",
          },
        );
        print('FB Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        //checks if the user is already sign up
        if (response.statusCode == 200) {
          showAlertDialog(context, 'Logged in successfully');
        } else {
          showAlertDialog(context, 'User doesn\'t exist');
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
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

  void sending() async {
    const String baseURL =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';

    var url =
        '$baseURL/register/logIn?email=${emailController.text}&password=${passwordController.text}';
    var response = await http.post(
      Uri.parse(url),
      body: {
        "email": "${emailController.text}",
        "password": "${passwordController.text}",
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var passLogin;

    if (response.statusCode == 200) {
      passLogin = true;
      // showAlertDialog(context, validateubmit());
    } else {
      passLogin = false;
      // showAlertDialog(context, 'Enter valid parameters');
    }

    if (passwordCheck && emailCheck) {
      print(passLogin);
      if (passLogin == true) {
        CommonVars.followers = await FlickrRequestsAndResponses.getFollowings();
        CommonVars.followings = await FlickrRequestsAndResponses.getFollowers();

        Navigator.pop(context);
        Navigator.pushNamed(context, "UserPage");
      } else {
        showAlertDialog(context, 'Wrong email or password');
      }
    } else {
      showAlertDialog(context, 'Enter valid email or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    var deviceSize = MediaQuery.of(context).size;
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Flickr',
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color(0xFF202023),
            leading: Image.asset(
              'images/flickricon.png',
              scale: deviceSize.width * 0.03,
            ),
            title: Title(
              child: Text(
                "flickr",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              color: Colors.white,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Image.asset(
                'images/flickricon.png',
                height: deviceSize.height * 0.04,
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text("Log in to Flickr"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: deviceSize.width * 0.06,
                  right: deviceSize.width * 0.06,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    validator: validateEmail,
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Email address',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: showPassword,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.01,
                      horizontal: deviceSize.width * 0.06),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      validator: validatePassword,
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !showPassword,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.01,
                      horizontal: deviceSize.width * 0.06),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    minWidth: deviceSize.width * 0.88,
                    onPressed: () {
                      previewPassword();
                    },
                    child: Text('Next'),
                  ),
                ),
              ),
              Visibility(
                visible: !showPassword,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: deviceSize.height * 0.01,
                        horizontal: deviceSize.width * 0.06),
                    // ignore: deprecated_member_use
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue[700],
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                          ),
                          // minimumSize:
                          //     Size(deviceSize.width, deviceSize.height / 10),
                          minimumSize:
                              Size(deviceSize.width, deviceSize.height / 20)),
                      onPressed: () {
                        _login();
                      },
                      icon: Image.asset(
                        "images/fb.png",
                        scale: deviceSize.width * 0.05,
                      ),
                      label: Text('Login in with Facebook'),
                    )),
              ),
              Visibility(
                visible: showPassword,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.01,
                      horizontal: deviceSize.width * 0.06),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    minWidth: deviceSize.width * 0.88,
                    onPressed: () {
                      sending();
                      // Navigator.pop(context);
                      //Navigator.pushNamed(context, "UserPage");
                    },
                    child: Text('Login'),
                  ),
                ),
              ),
              Visibility(
                visible: showPassword,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: " Forgot password?",
                        style: TextStyle(
                          color: Colors.blue.shade600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => forgetPass(
                                  receivedEmailController: emailController,
                                ),
                              ),
                            );
                          }),
                  ]),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Visibility(
                visible: showPassword,
                child: Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                  indent: deviceSize.width * 0.06,
                  endIndent: deviceSize.width * 0.06,
                ),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Not a Flickr member?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text: "Sign up here.",
                      style: TextStyle(
                        color: Colors.blue.shade600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          //Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                          print('Moved to third');
                        }),
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: deviceSize.height * 0.3),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        child: Text('Help'),
                        onTap: () => launch('https://help.flickr.com/'),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      GestureDetector(
                        child: Text('Privacy'),
                        onTap: () =>
                            launch('https://www.flickr.com/help/privacy'),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      GestureDetector(
                        child: Text('Terms'),
                        onTap: () =>
                            launch('https://www.flickr.com/help/terms'),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    emailCheck = false;
    return 'Enter a valid email address';
  } else {
    emailCheck = true;
    return null;
  }
}

String validatePassword(String value) {
  Pattern pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null) {
    passwordCheck = false;
    return 'Enter a valid Password (8 or more characters)';
  } else {
    passwordCheck = true;
    return null;
  }
}
