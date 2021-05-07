import 'dart:io';

import 'package:flickr/Screens/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Screens/Menu Class.dart';
import 'package:flickr/Screens/SignUp.dart';
import 'package:flickr/Screens/ChangePassword.dart';
import 'package:image_picker/image_picker.dart';
import 'about.dart';
import 'UploadImage.dart';
import 'package:http/http.dart' as http;

class UserPage2 extends StatefulWidget {
  @override
  _UserPage2 createState() => _UserPage2();
}

class _UserPage2 extends State<UserPage2> {
  // This widget is the root of your application.
  PickedFile _photofile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;
    double buttonwidth = deviceSizewidth / 5;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          RawMaterialButton(
            constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
            child: Icon(
              Icons.photo_size_select_actual_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: RawMaterialButton(
              constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
          ),
          RawMaterialButton(
            constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
            child: Icon(
              Icons.museum_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          RawMaterialButton(
            constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          RawMaterialButton(
            constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => CustomisedBottomSheet(context)),
              );
            },
            child: Icon(Icons.camera_alt_outlined),
          ),
          //onPressed: () {
          // do something
        ],
        toolbarHeight: deviceSizeheight * .07,
      ),
      body: UserPage(
        photoFile: _photofile,
      ),
    );
  }

  void ConvertingPhoto() async {
    final bytes = await _photofile.readAsBytes();
    sending(bytes);
    print(bytes);
  }

  void sending(final bytes) async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/photo/upload?photo=$bytes&isPublic=true&title=Cairo Tower&allowCommenting=true&license=""&contentType=""&safetyOption=""&description=""';

    var response = await http.post(Uri.parse(url), body: {
      {
        "photo":
            "[255, 216, 255, 225, 1, 25, 69, 120, 105, 102, 0, 0, 77, 77, 0, 42, 0, 0, 0, 8, 0, 5, 1, 0, 0, 3, 0, 0, 0, 1, 4, 56, 0, 0, 1, 1, 0, 3, 0, 0, 0, 1, 9, 96, 0, 0, 1, 49, 0, 2, 0, 0, 0, 38, 0, 0, 0, 74, 135, 105, 0, 4, 0, 0, 0, 1, 0, 0, 0, 112, 1, 18, 0, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 65, 110, 100, 114, 111, 105, 100, 32, 82, 80, 49, 65, 46, 50, 48, 48, 55, 50, 48, 46, 48, 49, 50, 46, 65, 53, 49, 53, 70, 88, 88, 85, 52, 68, 85, 66, 49, 0, 0, 4, 144, 3, 0, 2, 0, 0, 0, 20, 0, 0, 0, 166, 146, 145, 0, 2, 0, 0, 0, 4, 55, 48, 49, 0, 144, 17, 0, 2, 0, 0, 0, 7, 0, 0, 0, 186, 146, 8, 0, 4, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 50, 48, 50, 49, 58, 48, 53, 58, 48, 55, 32, 50, 50, 58, 48, 48, 58, 48, 52, 0, 43, 48, 50, 58, 48, 48, 0, 0, 3, 1, 0, 0, 3, 0, 0, 0, 1, 4, 56, 0, 0, 1, 49, 0, 2, 0, 0, 0, 38, 0, 0, 0, 235, 1, 1, 0, 3, 0, 0, 0, 1, 9, 96, 0, 0, 0, 0, 0, 0, 65, 110, 100, 114, 111, 105, 100, 32, 82, 80, 49, 65, 46, 50, 48, 48, 55, 50, 48, 46, 48, 49, 50, 46, 65, 53, 49, 53, 70, 88, 88, 85, 52, 68, 85, 66, 49, 0]",
        "isPublic": "true",
        "title": "Cairo Tower",
        "allowCommenting": "true",
        "license": "",
        "contentType": "",
        "safetyOption": "",
        "description": "A photo of Cairo tower at the sunset"
      }
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Widget tempImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              //borderRadius: BorderRadius.all(Radius.circular(.05)),//add border radius here
              _photofile == null
                  ? AssetImage('images/photo1.jpg')
                  : FileImage(File(_photofile.path)),
          fit: BoxFit.fitHeight, //add image location here
        ),
      ),
    );
  }

  Widget CustomisedBottomSheet(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceSizewidth * .4,
      width: deviceSizewidth,
//margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 40),
      child: Column(
        children: <Widget>[
          Text("Choose your photo", style: TextStyle(fontSize: 30)),
          SizedBox(height: deviceSizeheight * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                //   constraints: BoxConstraints.tight(Size(80, 80)),
                child: Icon(Icons.camera_alt_sharp, size: 40),
                onPressed: () {
                  phototaker(ImageSource.camera);
                },
              ),
              SizedBox(
                width: 20,
              ),
              RawMaterialButton(
                //    constraints: BoxConstraints.tight(Size(80, 80)),
                child: Icon(
                  Icons.image_rounded,
                  size: 40,
                ),
                onPressed: () {
                  print("gallery");
                  phototaker(ImageSource.gallery);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void phototaker(ImageSource source) async {
    final token = await _picker.getImage(source: source);
    setState(() {
      _photofile = token;
    });
    // ConvertingPhoto();
  }

  void MovingTo(String destination) {
    setState(() {
      if (destination == menu.Signout) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GetStarted()),
        );
      }
      if (destination == menu.ChangePassword) {
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangePassword()),
          );
        }
      }
      print(destination);
    });
  }
}
