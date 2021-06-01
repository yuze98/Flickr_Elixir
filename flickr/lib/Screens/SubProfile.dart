import 'dart:io';
import 'package:flickr/Screens/CameraRoll.dart';
import 'package:flickr/Screens/Public.dart';
import 'package:flickr/Screens/CameraRoll.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Screens/CommonVars.dart';
import 'package:flickr/Screens/ChangePassword.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about.dart';

class SubProfile extends StatefulWidget {
  PickedFile photoFile;
  SubProfile({Key key, @required this.photoFile}) : super(key: key);
  @override
  _SubProfile createState() => _SubProfile();
}

class _SubProfile extends State<SubProfile> {
  // This widget is the root of your application.

  //PickedFile  photoFile;
  final ImagePicker _picker = ImagePicker();
  PickedFile profilePhotoFile, coverPhotoFile;

  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;
    double buttonwidth = deviceSizewidth / 5;

    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool Scroll) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    expandedHeight: 250,
                    //  floating: true,
                    pinned: true,
                    backgroundColor: Colors.white,
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: deviceSizewidth * .8),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => customisedBottomSheet(
                                    context, coverPhotoFile)));
                          },
                          child: Icon(
                            Icons.photo_camera,
                          ),
                        ),
                      ),
//                              actions: <Widget>[
                      PopupMenuButton(
                        onSelected: movingTo,
                        color: Colors.white,
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),
                        itemBuilder: (BuildContext context) {
                          return CommonVars.menu.map((String s) {
                            return PopupMenuItem<String>(
                              value: s,
                              child: Text(s),
                            );
                          }).toList();
                        },
                      ),

                      //onPressed: () {
                      // do something
                    ],
                    toolbarHeight: deviceSizeheight * .07,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        width: deviceSizewidth,
                        padding: EdgeInsets.only(bottom: 42.0),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image(
                            fit: BoxFit.cover,
                            width: deviceSizewidth,
                            alignment: Alignment.center,
                            image: coverPhotoFile == null
                                ? AssetImage(
                                    'images/photo1.jpg',
                                  )
                                : FileImage(File(coverPhotoFile.path)),
                          ),
                        ),
                      ),
                      centerTitle: true,
                      titlePadding: EdgeInsets.only(bottom: 42.0),
                      title: Container(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Column(children: <Widget>[
                            Center(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: profilePhotoFile == null
                                        ? AssetImage('images/photo1.jpg')
                                        : FileImage(
                                            File(profilePhotoFile.path)),
                                    radius: 35.0,
                                  ),
                                  Positioned(
                                    left: deviceSizewidth * .1,
                                    top: deviceSizeheight * .07,
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) =>
                                                customisedBottomSheet(context,
                                                    profilePhotoFile)));
                                      },
                                      child: Icon(
                                        Icons.photo_camera,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'User 0',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${CommonVars.followers} followers - ',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                ),
                                Text(
                                  '${CommonVars.followings} following',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      indicatorColor: Colors.grey[800],
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.grey[800],
                      // These are the widgets to put in each tab in the tab bar.
                      tabs: [
                        Text(
                          'About',
                        ),
                        Text(
                          'Camera Roll',
                        ),
                        Text(
                          'Public',
                        ),
                        Text(
                          'Albums',
                        ),
                        Text(
                          'Groups',
                        ),
                      ],
                      isScrollable: true,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: [
                AboutState(),
                CameraRoll(),
                Public(),
                Icon(Icons.album_sharp),
                Icon(Icons.group),
              ]),
        ),
      ),
    );
  }

  Widget customisedBottomSheet(BuildContext context, PickedFile file) {
    double deviceSizeHeight = MediaQuery.of(context).size.height;
    double deviceSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceSizeWidth * .4,
      width: deviceSizeWidth,
//margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 40),
      child: Column(
        children: <Widget>[
          Text("Choose your photo", style: TextStyle(fontSize: 30)),
          SizedBox(height: deviceSizeHeight * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                //   constraints: BoxConstraints.tight(Size(80, 80)),
                child: Icon(Icons.camera_alt_sharp, size: 40),
                onPressed: () {
                  photoTaker(ImageSource.camera, file);
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
                  photoTaker(ImageSource.gallery, file);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void photoTaker(ImageSource source, PickedFile file) async {
    final token = await _picker.getImage(source: source);
    setState(() {
      file = token;
    });
    // ConvertingPhoto();
  }

  Widget tempImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              //borderRadius: BorderRadius.all(Radius.circular(.05)),//add border radius here
              widget.photoFile == null
                  ? AssetImage('images/photo1.jpg')
                  : FileImage(
                      File(widget.photoFile.path),
                    ),
          fit: BoxFit.fitHeight, //add image location here
        ),
      ),
    );
  }

  void movingTo(String destination) {
    setState(() {
      if (destination == CommonVars.signOut) {
        Navigator.pushNamedAndRemoveUntil(context, "GetStarted", (r) => false);
      }
      if (destination == CommonVars.changePassword) {
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangePassword()),
          );
        }
      }
      if (destination == CommonVars.about) {
        launch('https://www.flickr.com/about');
      }
      if (destination == CommonVars.help) {
        launch('https://www.flickr.com/help/terms');
      }
      print(destination);
    });
  }
}
