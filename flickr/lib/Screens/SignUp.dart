import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Image.asset('images/flickricon.png'),
          title: Text(
            'Flickr',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: 100,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 25.0,
            ),
            Image.asset(
              'images/flickricon.png',
              height: 35,
            ),
            Center(
              child: Text(
                'Sign up for Flickr',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(),
                  hintText: 'First name',
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(),
                  hintText: 'Second name',
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(),
                  hintText: 'Your age',
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(),
                  hintText: 'Email address',
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  fillColor: Colors.white,
                ),
              ),
            ),
            Container(
              height: 130.0,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Sign up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
