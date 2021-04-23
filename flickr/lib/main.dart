import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
        appBar: AppBar(
          title: Title(
            child: Text("Flicker"),
            color: Colors.blue,
          ),
        ),
        body: Container(
          color: Colors.redAccent[400],
        ),
      ),
    );
  }
}
