import 'package:flickr/Components/ImageList.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CommentSection.dart';
import 'package:flickr/Components/CommentsFavoritesNavigator.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';

class AboutPhoto extends StatefulWidget {
  @override
  _AboutPhotoState createState() => _AboutPhotoState();
}

class _AboutPhotoState extends State<AboutPhoto> {
  String title = "title";
  String takenBy = "fatoo7";
  String tags = "beststuff";
  String privacy = "private";
  String image =
      'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg';

  @override
  Widget build(BuildContext context) {
    var devSize = MediaQuery.of(context).size;

    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black87,
          child: Padding(
            padding: EdgeInsets.all(devSize.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "TITLE",
                  style: TextStyle(
                      fontSize: devSize.height * 0.015, color: Colors.grey),
                ),
                Text(
                  '$title',
                  style: TextStyle(
                      fontSize: devSize.height * 0.025, color: Colors.white),
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Text(
                  'TAKEN BY',
                  style: TextStyle(
                      fontSize: devSize.height * 0.015, color: Colors.grey),
                ),
                Text(
                  '$takenBy',
                  style: TextStyle(
                      fontSize: devSize.height * 0.025, color: Colors.white),
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Text(
                  'ALBUM',
                  style: TextStyle(
                      fontSize: devSize.height * 0.015, color: Colors.grey),
                ),
                SizedBox(
                  height: devSize.height * 0.1,
                  width: devSize.width * 0.2,
                  child: Container(
                    child: Image.network(image),
                  ),
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Text(
                  'TAGS',
                  style: TextStyle(
                      fontSize: devSize.height * 0.015, color: Colors.grey),
                ),
                Text(
                  '$tags',
                  style: TextStyle(
                      fontSize: devSize.height * 0.025, color: Colors.white),
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Text(
                  'LICENSE',
                  style: TextStyle(
                      fontSize: devSize.height * 0.015, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(Icons.copyright),
                    Padding(
                      padding: EdgeInsets.only(left: devSize.width * 0.02),
                      child: Text(
                        'All rights reserved',
                        style: TextStyle(
                            fontSize: devSize.height * 0.025,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Text(
                  'MORE',
                  style: TextStyle(
                      fontSize: devSize.height * 0.015, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(Icons.lock),
                    Padding(
                      padding: EdgeInsets.only(left: devSize.width * 0.02),
                      child: Text(
                        '$privacy',
                        style: TextStyle(
                            fontSize: devSize.height * 0.025,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
