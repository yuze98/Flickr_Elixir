import 'dart:ui';
import 'dart:convert';
import 'package:flickr/Components/ExploreDetails.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Components/CommentsFavoritesNavigator.dart';

class CommonFunctions {
  void showAlertDialog(BuildContext context, String imageList) {
    // Create button
    Widget okButton = Row(
      children: <Widget>[
        TextButton(
          child: Text(
            "Share with friends",
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.025),
          ),
          onPressed: () {
            //share function
          },
        ),
      ],
    );

    AlertDialog alert = AlertDialog(
      title: Text("Share this photo"),
      content: Image.network(imageList),
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

  Widget CommentsFunction(BuildContext context, String commentsNum,
      String favCount, String userName, String picId) {
    // Create button

    return IconButton(
      icon: Icon(
        Icons.comment,
        color: Colors.grey,
      ),
      tooltip: 'Open comment Section',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommentsFavoritesNavigator(
              commentsNumber: commentsNum,
              favoriteNumber: favCount,
              userName: userName,
              picId: picId,
            ),
          ),
        );
      },
    );
  }
}
