import 'dart:io';

import 'package:flickr/Screens/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Screens/Menu Class.dart';
import 'package:flickr/Screens/SignUp.dart';
import 'package:flickr/Screens/ChangePassword.dart';
import 'package:image_picker/image_picker.dart';

class UserPage1 extends StatefulWidget {
  @override
  _UserPage1 createState() => _UserPage1();
}

class _UserPage1 extends State<UserPage1> {
  // This widget is the root of your application.
  PickedFile _photofile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;
    double buttonwidth = deviceSizewidth / 5;

    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
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
          body: Container(
            width: deviceSizewidth,
            height: deviceSizeheight,
            child: Stack(children: <Widget>[
              Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 4,
                  direction: Axis.horizontal,
                  children: [
                    tempImage() /*,tempImage(),tempImage(),tempImage(),tempImage(),tempImage(),tempImage(),tempImage()*/
                  ]),
              Positioned(
                //top:deviceSizeheight*.45,
                left: deviceSizewidth * .85,

                child: PopupMenuButton(
                  onSelected: MovingTo,
                  color: Colors.white,
                  itemBuilder: (BuildContext context) {
                    return menu.Menu.map((String s) {
                      return PopupMenuItem<String>(
                        value: s,
                        child: Text(s),
                      );
                    }).toList();
                  },
                ),
              ),
            ]),
          )),
    );
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
