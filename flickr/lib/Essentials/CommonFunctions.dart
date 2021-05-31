import 'dart:ui';
import 'dart:convert';
import 'package:flickr/Components/ExploreDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Essentials/CommonVars.dart';

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

  void EditWithIcon(
      BuildContext context, String title, bool isEditable, double fontSizing) {
    // Create button
    Widget okButton = Column(
      children: <Widget>[
        Text(
          'LICENSE',
          style: TextStyle(fontSize: fontSizing * 2, color: Colors.grey),
        ),
        IconButton(icon: Icon(Icons.edit), onPressed: () => {})
      ],
    );

    AlertDialog alert = AlertDialog(
      title: Text('$title'),
      content: Text('Here will be a text Form'),
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
}
