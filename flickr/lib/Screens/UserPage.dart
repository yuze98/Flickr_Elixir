import 'dart:io';
import 'package:flickr/api/RequestAndResponses.dart';
import 'Explore.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'SubProfile.dart';
import 'dart:ui';
import 'SearchScreen.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  // This widget is the root of your application.
  PickedFile photoFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    FlickrRequestsAndResponses.getAbout();
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;
    double buttonwidth = deviceSizewidth / 5;
    double buttonWidth = deviceSizewidth / 5;
    final ImagePicker _picker = ImagePicker();
    PickedFile _photofile;
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
                    automaticallyImplyLeading: false,
                    //  floating: true,
                    toolbarHeight: deviceSizeheight * .05,

                    backgroundColor: Colors.black,
                    bottom: TabBar(
                      indicatorColor: Colors.grey[800],
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.grey[800],

                      // These are the widgets to put in each tab in the tab bar.
                      tabs: [
                        RawMaterialButton(
                          child: Icon(
                            Icons.photo_size_select_actual_outlined,
                          ),
                        ),
                        RawMaterialButton(
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                        RawMaterialButton(
                          child: Icon(
                            Icons.museum_rounded,
                          ),
                        ),
                        RawMaterialButton(
                          child: Icon(
                            Icons.notifications,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) =>
                                  customisedBottomSheet(context)),
                            );
                          },
                          child: Icon(
                            Icons.camera_alt_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: [
                ImageList(),
                SearchScreen(),
                SubProfile(photoFile: photoFile),
                Icon(Icons.album_sharp),
                Icon(Icons.group),
              ]),
        ),
      ),
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
              photoFile == null
                  ? AssetImage('images/photo1.jpg')
                  : FileImage(File(photoFile.path)),
          fit: BoxFit.fitHeight, //add image location here
        ),
      ),
    );
  }

  Widget customisedBottomSheet(BuildContext context) {
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
                  photoTaker(ImageSource.camera);
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
                  photoTaker(ImageSource.gallery);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void photoTaker(ImageSource source) async {
    var token = await _picker.getImage(source: source);
    if (token == null) return;

    setState(() {
      CommonVars.photoFile = token;
    });

    Navigator.pushNamed(context, 'UploadDetails');
    // FlickrRequestsAndResponses.uploadImage();
  }
} //assef gedan
