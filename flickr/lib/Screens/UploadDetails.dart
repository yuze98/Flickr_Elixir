import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDetails extends StatefulWidget {
  @override
  _ImageDetails createState() => _ImageDetails();
}

class _ImageDetails extends State<ImageDetails> {
  // This widget is the root of your application.
  bool descriptionBool = false;
  bool titleBool = false;
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();
  Future<String> check;
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
          actions: [
            IconButton(
              icon: Icon(Icons.navigate_next, color: Colors.white),
              onPressed: () {
                setState(() async {
                  CommonVars.title = titleController.text;
                  CommonVars.description = descriptionController.text;
                  Navigator.pushNamed(context, 'LoadingScreen');
                  check = FlickrRequestsAndResponses.uploadImage();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'UserPage');
                });
                uploadPhoto();
              },
            ),
          ],
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
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  deviceSizewidth * 0.06,
                  deviceSizeheight * 0.01,
                  deviceSizewidth * 0.06,
                  deviceSizeheight * 0.01),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: validateTitle,
                  controller: titleController,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Title',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  deviceSizewidth * 0.06,
                  deviceSizeheight * 0.01,
                  deviceSizewidth * 0.06,
                  deviceSizeheight * 0.01),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: validateDescription,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Description',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: deviceSizewidth * .7),
              child: FlatButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "Tags");
                  },
                  icon: Icon(Icons.label, color: Colors.black26),
                  color: Colors.transparent,
                  label: Text("Tags   ",
                      style: TextStyle(color: Colors.black26, fontSize: 16.0))),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  String validateTitle(String value) {
    Pattern pattern = r"^[a-z A-Z]+$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      descriptionBool = false;
      titleBool = false;
      return 'Enter a valid Title';
    } else {
      descriptionBool = true;
      titleBool = true;
      return null;
    }
  }

  String validateConfirm() {
    String str;
    if (!descriptionBool || !titleBool) {
      str = 'Please enter valid parameters!';
    } else {
      str = 'done';
    }
    return str;
  }

  void uploadPhoto() async {
    /*await FlickrRequestsAndResponses.changePassword(
        newPasswordController, oldPasswordController);*/
    if (check != null) {
      showAlertDialog(context, validateConfirm());
    } else {
      showAlertDialog(context, 'Enter valid parameters');
    }
  }

  String validateDescription(String value) {
    Pattern pattern = r"^[a-z A-Z]+$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid Description';
    } else {
      return null;
    }
  }

  showAlertDialog(BuildContext context, String str) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (str == 'Enter a valid Description')
          Navigator.pushNamedAndRemoveUntil(context, "UserPage", (r) => false);
        else
          Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(str),
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
