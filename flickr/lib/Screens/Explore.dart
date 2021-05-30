import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Components/ImageList.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: ImageList(),
        ),
      ),
    );
  }
}
