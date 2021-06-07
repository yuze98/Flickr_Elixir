import 'package:flickr/Components/FollowingsList.dart';
import 'Public.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:image_picker/image_picker.dart';
import 'OtherUserAbout.dart';
import 'AlbumScreen.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flickr/Components/FollowersList.dart';
import 'SubPhotoStream.dart';

class OtherProfile extends StatefulWidget {
  PickedFile photoFile;
  String userId;

  @override
  _OtherProfile createState() => _OtherProfile();
}

class _OtherProfile extends State<OtherProfile> {
  // This widget is the root of your application.

  final ImagePicker _picker = ImagePicker();
  PickedFile profilePhotoFile, coverPhotoFile;

  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;
    double buttonWidth = deviceSizewidth / 5;
    CommonVars.sameUser = false;
    print(
        "is followinggggggggggggggggggggggggggggggggggg ${CommonVars.isFollowing}");
    return Scaffold(
      body: DefaultTabController(
        length: 4,
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
                    expandedHeight: 250,
                    //  floating: true,
                    pinned: true,
                    backgroundColor: Colors.white,
                    actions: <Widget>[],
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
                            image: CommonVars.othersCoverPhotoUrl == null
                                ? AssetImage(
                                    'images/photo1.jpg',
                                  )
                                : NetworkImage(CommonVars.othersCoverPhotoUrl),
                          ),
                        ),
                      ),
                      centerTitle: true,
                      titlePadding: EdgeInsets.only(bottom: 42.0),
                      title: Container(
                        padding: EdgeInsets.only(top: deviceSizeheight * .12),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Column(children: <Widget>[
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      CommonVars.othersProfilePhotoUrl == null
                                          ? AssetImage('images/photo1.jpg')
                                          : NetworkImage(
                                              CommonVars.othersProfilePhotoUrl),
                                  radius: 35.0,
                                ),
                              ],
                            ),
                            Text(
                              CommonVars.otherUserName,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      '${CommonVars.othersFollowers} followers - ',
                                      style: TextStyle(
                                          fontSize: 10.0, color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FollowersList(
                                            userId: CommonVars.otherUserId,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GestureDetector(
                                      child: Text(
                                        '${CommonVars.othersFollowings} following',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FollowingsList(
                                              userId: CommonVars.otherUserId,
                                            ),
                                          ),
                                        );
                                      }),
                                  IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: CommonVars.isFollowing
                                          ? Icon(
                                              Icons.arrow_downward_sharp,
                                              size: 20,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.arrow_upward_sharp,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                      onPressed: () async {
                                        if (!CommonVars.isFollowing)
                                          await FlickrRequestsAndResponses
                                              .followUser(
                                                  CommonVars.otherUserId);
                                        else
                                          await FlickrRequestsAndResponses
                                              .unFollowUser(
                                                  CommonVars.otherUserId);
                                      })
                                ],
                              ),
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
                OtherUserAboutState(),
                SubPhotoStream(),
                AlbumScreen(),
                Icon(Icons.group),
              ]),
        ),
      ),
    );
  }
}
