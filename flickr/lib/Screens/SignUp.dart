import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              devicesize.width * 0.06, 0, devicesize.width * 0.06, 0),
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
                    devicesize.width * 0.06,
                    devicesize.height * 0.07,
                    devicesize.width * 0.06,
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
                child: Text(
                  "By signing up you afree with Flickr's Terms of Services and Privacy Policy.",
                  style: TextStyle(
                    fontSize: devicesize.width * 0.035,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
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
