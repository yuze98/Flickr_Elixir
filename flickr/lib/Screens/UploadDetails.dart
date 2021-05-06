import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageDetails extends StatefulWidget {
  @override
  _ImageDetails createState() => _ImageDetails();
}

class _ImageDetails extends State<ImageDetails> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
        resizeToAvoidBottomInset: false, //new line

        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Image.asset('images/flickricon.png'),
          title: Text(
            'Image Details ',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: deviceSizeheight * .1,
        ),
        body: Column(
          children: [],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
