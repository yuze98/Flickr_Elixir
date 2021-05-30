import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentsSection extends StatefulWidget {
  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  String profilePic =
      'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg';

  String userName = 'Thor Odin';
  String comment = 'This is a comment yey';

  List<Widget> commentsList = [];

  @override
  Widget build(BuildContext context) {
    Widget widggy = CommentInfo(context, profilePic, userName, comment);
    commentsList.add(widggy);

    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: ListView.builder(
          itemCount: commentsList.length,
          itemBuilder: (context, index) => commentsList[index],
        )),
      ),
    );
  }

  Widget CommentInfo(BuildContext context, String profilePic, String userName,
      String comment) {
    var devSize = MediaQuery.of(context).size;
    return Container();
  }
}
