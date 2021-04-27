import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final firstnameController = TextEditingController();
  final secondnameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                child: TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'First name',
                    fillColor: Colors.white,
                  ),
                  //  ),
                ),
              ), //first name
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: TextField(
                  controller: secondnameController,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Second name',
                    fillColor: Colors.white,
                  ),
                ),
              ), // second name
              Padding(
                padding: EdgeInsets.fromLTRB(
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
                child: TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Your age',
                    fillColor: Colors.white,
                  ),
                ),
              ), //your age
              Padding(
                padding: EdgeInsets.fromLTRB(
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Email address',
                    fillColor: Colors.white,
                  ),
                ),
              ), //email address
              Padding(
                padding: EdgeInsets.fromLTRB(
                    devicesize.width * 0.06,
                    devicesize.height * 0.01,
                    devicesize.width * 0.06,
                    devicesize.height * 0.01),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    fillColor: Colors.white,
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
                    backgroundColor: Colors.blue,
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
                  Navigator.pushNamed(context, '/second');
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
}

_launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
