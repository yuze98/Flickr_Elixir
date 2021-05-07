import 'dart:io';

import 'package:flickr/Screens/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Screens/Menu Class.dart';
import 'package:flickr/Screens/SignUp.dart';
import 'package:flickr/Screens/ChangePassword.dart';
import 'package:image_picker/image_picker.dart';
import 'UploadImage1.dart';

import 'about.dart';

class UserPage extends StatefulWidget {
  PickedFile photoFile;
  UserPage({Key key, @required this.photoFile}) : super(key: key);
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  // This widget is the root of your application.

  //PickedFile  photoFile;
  final ImagePicker _picker = ImagePicker();
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
//                              actions: <Widget>[
                      PopupMenuButton(
                        onSelected: MovingTo,
                        color: Colors.white,
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),
                        itemBuilder: (BuildContext context) {
                          return menu.Menu.map((String s) {
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
                        padding: EdgeInsets.only(bottom: 42.0),
                        child: FittedBox(
                          child: Image.asset('images/photo1.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      centerTitle: true,
                      titlePadding: EdgeInsets.only(bottom: 42.0),
                      title: Container(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Column(children: <Widget>[
                            CircleAvatar(
                              backgroundImage: widget.photoFile == null
                                  ? AssetImage('images/photo1.jpg')
                                  : FileImage(File(widget.photoFile.path)),
                              radius: 35.0,
                            ),
                            Text(
                              'User 0',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.grey[900]),
                            ),
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
                Icon(Icons.camera),
                Icon(Icons.public),
                Icon(Icons.album_sharp),
                Icon(Icons.group),
              ]),
        ),
      ),
    );

    //
    //
    //         Scaffold(
    //       appBar: AppBar(
    //
    //         backgroundColor: Colors.black,
    //         actions: <Widget>[
    //           RawMaterialButton(
    //             constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
    //             child: Icon(
    //               Icons.photo_size_select_actual_outlined,
    //               color: Colors.white,
    //             ),
    //             onPressed: () {
    //               // do something
    //             },
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(0.0),
    //             child: RawMaterialButton(
    //               constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
    //               child: Icon(
    //                 Icons.search,
    //                 color: Colors.white,
    //               ),
    //               onPressed: () {
    //                 // do something
    //               },
    //             ),
    //           ),
    //           RawMaterialButton(
    //             constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
    //             child: Icon(
    //               Icons.museum_rounded,
    //               color: Colors.white,
    //             ),
    //             onPressed: () {
    //               // do something
    //             },
    //           ),
    //           RawMaterialButton(
    //             constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
    //             child: Icon(
    //               Icons.notifications,
    //               color: Colors.white,
    //             ),
    //             onPressed: () {
    //               // do something
    //               Navigator.pushNamed(context, "about");
    //             },
    //           ),
    //           RawMaterialButton(
    //             constraints: BoxConstraints.tight(Size(buttonwidth, 80)),
    //             onPressed: () {
    //               showModalBottomSheet(
    //                 context: context,
    //                 builder: ((builder) => CustomisedBottomSheet(context)),
    //               );
    //             },
    //             child: Icon(Icons.camera_alt_outlined),
    //           ),
    //           //onPressed: () {
    //           // do something
    //         ],
    //         toolbarHeight: deviceSizeheight * .07,
    //       ),
    //       body: Container(
    //         width: deviceSizewidth,
    //         height: deviceSizeheight,
    //         child: Stack(children: <Widget>[
    //           Wrap(
    //               alignment: WrapAlignment.start,
    //               spacing: 10,
    //               runSpacing: 4,
    //               direction: Axis.horizontal,
    //               children: [
    //                 tempImage() /*,tempImage(),tempImage(),tempImage(),tempImage(),tempImage(),tempImage(),tempImage()*/
    //               ]),
    //           Positioned(
    //             //top:deviceSizeheight*.45,
    //             left: deviceSizewidth * .85,
    //
    //             child: PopupMenuButton(
    //               onSelected: MovingTo,
    //               color: Colors.white,
    //               itemBuilder: (BuildContext context) {
    //                 return menu.Menu.map((String s) {
    //                   return PopupMenuItem<String>(
    //                     value: s,
    //                     child: Text(s),
    //                   );
    //                 }).toList();
    //               },
    //             ),
    //           ),
    //         ]),
    //       )),
    // );
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
                  : FileImage(File(widget.photoFile.path)),
          fit: BoxFit.fitHeight, //add image location here
        ),
      ),
    );
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
