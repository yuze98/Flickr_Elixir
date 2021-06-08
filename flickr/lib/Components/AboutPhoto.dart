import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Models/AboutPhotoModel.dart';
import 'package:flickr/Screens/AlbumScreen.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Essentials/LoadingScreen.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';
import 'package:flutter/rendering.dart';

/// Shows the details of the photo.
/// Allows you to delete, add tags and go to its album if it is in an album.
/// Add photo to an album if the image is yours
/// @picId : Picutre ID
/// @userId : User ID

class AboutPhoto extends StatefulWidget {
  final picId, userId;
  AboutPhoto({
    Key key,
    this.picId,
    this.userId,
  }) : super(key: key);

  @override
  _AboutPhotoState createState() => _AboutPhotoState();
}

class _AboutPhotoState extends State<AboutPhoto> {
  final titleController = TextEditingController();
  final tagsController = TextEditingController();

  String title = 'title';
  String takenBy = "name";
  String tags = "tag";
  String privacy = "Private";
  String image =
      'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg';

  List<String> privacyList = ["Public", "Private"];
  List<String> tagList = ['tags'];

  bool tiitleBool = false;
  bool albumBool = false;
  bool tagsBool = false;
  bool moreBool = false;
  bool isUser = false;

  AboutPhotoModel aboutPic;

  void prepareAbout() async {
    // Navigator.pushNamed(context, 'LoadingScreen');
    aboutPic = await FlickrRequestsAndResponses.getAboutPhoto(widget.picId);

    //  Navigator.pop(context);
    setState(() {
      title = aboutPic.title;
      aboutPic.isPublic ? privacy = 'Public' : privacy = 'Private';
      tagList = aboutPic.tags;
      takenBy = '${aboutPic.firstName} ${aboutPic.lastName}';
      image = '${aboutPic.albumPic}';
      if (widget.userId == CommonVars.userId) {
        isUser = true;
      } else {
        isUser = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    prepareAbout();
  }

  @override
  Widget build(BuildContext context) {
    var devSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.black87,
          child: Padding(
            padding: EdgeInsets.all(devSize.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "TITLE",
                      style: TextStyle(
                          fontSize: devSize.height * 0.015, color: Colors.grey),
                    ),
                    isUser
                        ? IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: devSize.height * 0.025,
                            ),
                            onPressed: () {
                              setState(() {
                                tiitleBool = !tiitleBool;
                                title = titleController.text;

                                if (privacy == 'Private')
                                  FlickrRequestsAndResponses.editPhoto(
                                      widget.picId, false, title);
                                else
                                  FlickrRequestsAndResponses.editPhoto(
                                      widget.picId, true, title);
                              });
                            },
                          )
                        : Text(''),
                  ],
                ),
                Flexible(
                  child: TextField(
                    controller: titleController,
                    style: TextStyle(
                        fontSize: devSize.height * 0.025, color: Colors.white),
                    enabled: tiitleBool,
                    decoration: InputDecoration(
                      hintText: '$title',
                      hintStyle: TextStyle(
                          fontSize: devSize.height * 0.025,
                          color: Colors.white),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: devSize.height * 0.03,
                // ),
                Text(
                  'TAKEN BY',
                  style: TextStyle(
                      fontSize: devSize.height * 0.015, color: Colors.grey),
                ),
                Text(
                  '$takenBy',
                  style: TextStyle(
                      fontSize: devSize.height * 0.025, color: Colors.blue),
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Row(
                  children: [
                    Text(
                      'ALBUM',
                      style: TextStyle(
                          fontSize: devSize.height * 0.015, color: Colors.grey),
                    ),
                    isUser
                        ? IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: devSize.height * 0.025,
                            ),
                            onPressed: () {
                              setState(() {
                                albumBool = !albumBool;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AlbumScreen(
                                              receivedPicId: widget.picId,
                                              receivedUserId: widget.userId,
                                            )));
                              });
                            },
                          )
                        : Text(''),
                  ],
                ),

                SizedBox(
                  height: devSize.height * 0.1,
                  width: devSize.width * 0.2,
                  child: Container(
                    color: albumBool ? Colors.grey : Colors.transparent,
                    child: GestureDetector(
                      child: Image.network(image),
                      onTap: () {
                        //Go to Album page

                        albumBool
                            ? print("go to album")
                            : print("not editable");
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Row(
                  children: [
                    Text(
                      'TAGS',
                      style: TextStyle(
                          fontSize: devSize.height * 0.015, color: Colors.grey),
                    ),
                    isUser
                        ? IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: devSize.height * 0.025,
                            ),
                            onPressed: () {
                              setState(() {
                                tagsBool = !tagsBool;
                              });
                            },
                          )
                        : Text(''),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: tagList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: devSize.height * 0.2,
                                color: Colors.transparent,
                                child: Container(
                                  child: Text(
                                    '${tagList[index]} ',
                                    style: TextStyle(
                                        fontSize: devSize.width * 0.045,
                                        color: Colors.redAccent[100]),
                                  ),
                                ),
                              );
                            }),
                      ),
                      isUser
                          ? TextFormField(
                              enabled: tagsBool,
                              controller: tagsController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        FlickrRequestsAndResponses.addTags(
                                            widget.picId, tagsController.text);
                                        for (var i = 0;
                                            i < tagList.length;
                                            i++) {
                                          if (tagList[i].toLowerCase() ==
                                              tagsController.text
                                                  .toLowerCase()) {
                                            // Found the person, stop the loop
                                            return;
                                          }
                                        }
                                        tagList.insert(0, tagsController.text);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                                filled: true,
                                hintText: 'Add Tag',
                                hintStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.transparent,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Text(
                  'LICENSE',
                  style: TextStyle(
                      fontSize: devSize.height * 0.015, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.copyright,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: devSize.width * 0.02),
                      child: Text(
                        'All rights reserved',
                        style: TextStyle(
                            fontSize: devSize.height * 0.025,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: devSize.height * 0.03,
                ),
                Row(
                  children: [
                    Text(
                      'MORE',
                      style: TextStyle(
                          fontSize: devSize.height * 0.015, color: Colors.grey),
                    ),
                    isUser
                        ? IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: devSize.height * 0.025,
                            ),
                            onPressed: () {
                              setState(() {
                                moreBool = !moreBool;
                              });
                            },
                          )
                        : Text(''),
                  ],
                ),
                Row(
                  children: [
                    PopupMenuButton(
                      enabled: moreBool,
                      onSelected: (value) {
                        setState(() {
                          privacy = value;
                        });

                        if (value == 'Private')
                          FlickrRequestsAndResponses.editPhoto(
                              widget.picId, false, title);
                        else
                          FlickrRequestsAndResponses.editPhoto(
                              widget.picId, true, title);

                        if (value == 'Private') {
                          CommonVars.privateList.add(image);
                          if (CommonVars.publicList.contains(image)) {
                            CommonVars.publicList.remove(image);
                            print("adding in public");
                          }
                        } else {
                          CommonVars.publicList.add(image);
                          if (CommonVars.privateList.contains(image)) {
                            CommonVars.privateList.remove(image);
                            print("adding in public");
                          }
                        }
                      },
                      icon: Icon(
                        privacy == 'Private' ? Icons.lock : Icons.public,
                        color: moreBool ? Colors.black : Colors.grey,
                      ),
                      color: Colors.white,
                      itemBuilder: (BuildContext context) {
                        return privacyList.map((String s) {
                          return PopupMenuItem<String>(
                            value: s,
                            child: Text(s),
                          );
                        }).toList();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: devSize.width * 0.02),
                      child: Text(
                        '$privacy',
                        style: TextStyle(
                            fontSize: devSize.height * 0.025,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: devSize.width * 0.5,
                    ),
                    isUser
                        ? IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              //delete function request
                              FlickrRequestsAndResponses.deletePicture(
                                  widget.picId);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          )
                        : Text(''),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
