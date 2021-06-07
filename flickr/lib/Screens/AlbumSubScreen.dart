import 'package:flickr/Screens/SignUp.dart';

import 'AlbumScreen.dart';
import 'dart:io';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flickr/Models/GetAlbumMedia.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flickr/Components/ExploreDetails.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';

class AlbumSubScreen extends StatefulWidget {
  AlbumSubScreen({
    this.receivedAlbumID,
    this.receivedAlbumName,
    this.receivedNumberOfPhotos,
    @required this.receivedUserId,
  });
  // List of images and add it in the initializer
  final String receivedAlbumID;
  final String receivedAlbumName;
  final int receivedNumberOfPhotos;
  final String receivedUserId;

  @override
  _AlbumSubScreenState createState() => _AlbumSubScreenState();
}

class _AlbumSubScreenState extends State<AlbumSubScreen> {
  String albumID;
  String albumName;
  int numberOfPhotos;
  Future<List<GetAlbumMediaModel>> listOfAlbumMedia;

  List<String> picIdList = [];
  List<String> userNameList = [];
  List<String> imageUrlList = [];
  List<String> imagesTitleList = [];
  List<int> favCountList = [];
  List<int> commetNumList = [];
  List<String> albumPublicList = List();
  List<String> albumPrivateList = List();

  List<String> _selectedImagesId = [];
  List<int> _selectedIndexList = [];
  bool _selectionMode = false;
  bool tapped = false;

  @override
  void initState() {
    super.initState();
    albumID = widget.receivedAlbumID;
    albumName = widget.receivedAlbumName;
    numberOfPhotos = widget.receivedNumberOfPhotos;

    listOfAlbumMedia = FlickrRequestsAndResponses.getAlbumMedia(albumID);
    // Get list of images
  }

  PickedFile coverPhotoFile;

  static const List<String> menu = <String>['Rename', 'Delete'];
  static const List<String> deleteIconMenu = [
    'Remove from album',
    'Delete from Flickr'
  ];

  Future refreshScreen() async {
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumSubScreen(
          receivedAlbumID: albumID,
          receivedAlbumName: albumName,
          receivedNumberOfPhotos: numberOfPhotos,
          receivedUserId: widget.receivedUserId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    picIdList.clear();
    userNameList.clear();
    imageUrlList.clear();
    imagesTitleList.clear();
    favCountList.clear();
    commetNumList.clear();
    albumPublicList.clear();
    albumPrivateList.clear();

    String numberOfPhotosString = numberOfPhotos > 1
        ? numberOfPhotos.toString() + ' photos'
        : numberOfPhotos.toString() + ' photo';
    double deviceSizewidth = MediaQuery.of(context).size.width;
    double deviceSizeheight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: refreshScreen,
      child: Scaffold(
        body: DefaultTabController(
          length: 5,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool scroll) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      expandedHeight: 250,
                      pinned: true,
                      backgroundColor: Colors.white,
                      actions: <Widget>[
                        (widget.receivedUserId == CommonVars.userId)
                            ? PopupMenuButton(
                                onSelected: movingTo,
                                color: Colors.white,
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return menu.map((String s) {
                                    return PopupMenuItem<String>(
                                      value: s,
                                      child: Text(s),
                                    );
                                  }).toList();
                                },
                              )
                            : Text(''),
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
                                    Text(albumName),
                                  ],
                                ),
                              ),
                              Text(
                                numberOfPhotosString,
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.white),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Stack(
              children: <Widget>[
                FutureBuilder<List<GetAlbumMediaModel>>(
                  future: listOfAlbumMedia,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<GetAlbumMediaModel> data = snapshot.data;
                      for (var i in data) {
                        picIdList.add(i.picId);
                        userNameList.add(i.firstName + ' ' + i.lastName);
                        imageUrlList.add(i.url);
                        imagesTitleList.add(i.title);
                        favCountList.add(i.favoriteCount);
                        commetNumList.add(i.commentsNum);
                      }
                      return _createBody();
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                AnimatedOpacity(
                  opacity: tapped ? 1.0 : 0.0,
                  duration: Duration(
                    milliseconds: 250,
                  ),
                  child: Visibility(
                    child: OverLay(context),
                    visible: tapped,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget OverLay(BuildContext context) {
    var devSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ButtonBar(
              buttonTextTheme: ButtonTextTheme.accent,
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.share_sharp),
                  tooltip: 'Share',
                  onPressed: () {
                    // Not useful as it was canceled
                    setState(() {
                      if (_selectedIndexList.isNotEmpty)
                        CommonFunctions().showAlertDialog(context,
                            CommonVars.imageList[_selectedIndexList[0]]);
                    });
                  },
                ),
                PopupMenuButton(
                  onSelected: deleteIconClicked,
                  color: Colors.white,
                  tooltip: 'Delete/Remove photo',
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  itemBuilder: (BuildContext context) {
                    return deleteIconMenu.map(
                      (String s) {
                        return PopupMenuItem<String>(
                          value: s,
                          child: new Container(
                            width: devSize.width,
                            child: Text(s),
                          ),
                        );
                      },
                    ).toList();
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.photo_album,
                    color: Colors.black,
                  ),
                  tooltip: 'Add Selected Items to Album',
                  onPressed: () {
                    if (_selectedImagesId.length == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumScreen(
                            receivedPicId: _selectedImagesId[0],
                            receivedUserId: CommonVars.userId,
                          ),
                        ),
                      );
                    } else {
                      for (int i = 0; i < _selectedImagesId.length; i++) {
                        for (int j = 0; j < picIdList.length; j++) {
                          if (_selectedImagesId[i] == picIdList[j]) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumScreen(
                                    receivedPicId: _selectedImagesId[i],
                                    receivedUserId: CommonVars.userId),
                              ),
                            );
                          }
                        }
                      }
                    }
                  },
                ),
                PopupMenuButton(
                  onSelected: privacySettings,
                  color: Colors.white,
                  icon: Icon(
                    Icons.privacy_tip,
                    color: Colors.black,
                  ),
                  itemBuilder: (BuildContext context) {
                    return CommonVars.privacy.map((String s) {
                      return PopupMenuItem<String>(
                        value: s,
                        child: new Container(
                          width: devSize.width,
                          child: Text(s),
                        ),
                      );
                    }).toList();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void movingTo(String destination) {
    TextEditingController renameController = TextEditingController();
    if (destination == 'Rename') {
      showDialog(
        context: context,
        builder: (context) {
          // Popup with a text field to enter name then save or cancel option
          return AlertDialog(
            title: Text('Rename album'),
            content: TextField(
              controller: renameController,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                hintText: 'Enter a name for your album',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  String newAlbumName = renameController.text.toString().trim();
                  if (newAlbumName.isNotEmpty) {
                    Navigator.of(context).pop(newAlbumName);
                    // Request change album title
                    FlickrRequestsAndResponses.renameAlbum(
                        albumID, newAlbumName);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                color: Colors.white,
                textColor: Colors.grey,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                ),
              ),
            ],
          );
        },
      );
    } else if (destination == 'Delete') {
      // Popup with are you sure you to delete and cancel and delete button
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete album'),
            content:
                Text('Are you sure you want to delete the album $albumName?'),
            actions: <Widget>[
              FlatButton(
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  // Request Album delete
                  FlickrRequestsAndResponses.DeleteAlbum(albumID);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                color: Colors.white,
                textColor: Colors.grey,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void deleteIconClicked(String destination) {
    if (_selectedIndexList.length == 1) {
      if (destination == 'Delete from Flickr') {
        print('delete image');
        FlickrRequestsAndResponses.deletePicture(_selectedImagesId[0]);
      } else if (destination == 'Remove from album') {
        print('remove from album');
        FlickrRequestsAndResponses.removePicFromAlbum(
            _selectedImagesId[0], albumID);
      }
    } else {
      for (int i = 0; i < _selectedImagesId.length; i++) {
        for (int j = 0; j < picIdList.length; j++) {
          if (_selectedImagesId[i] == picIdList[j]) {
            if (destination == 'Delete from Flickr') {
              print('delete imagesss');

              FlickrRequestsAndResponses.deletePicture(_selectedImagesId[i]);
            } else if (destination == 'Remove from album') {
              print('remove imagess from album');
              FlickrRequestsAndResponses.removePicFromAlbum(
                  _selectedImagesId[i], albumID);
            }
          }
        }
      }
    }
  }

  void privacySettings(String destination) {
    setState(() {
      if (destination == CommonVars.public) {
        //here we need to set the privacy of this to public

        for (int i = 0; i < _selectedIndexList.length; i++) {
          if (!CommonVars.publicList
              .contains(CommonVars.imageList[_selectedIndexList[i]])) {
            CommonVars.publicList
                .add(CommonVars.imageList[_selectedIndexList[i]]);

            if (CommonVars.privateList
                .contains(CommonVars.imageList[_selectedIndexList[i]])) {
              CommonVars.privateList
                  .remove(CommonVars.imageList[_selectedIndexList[i]]);

              print("removing from private");
            }

            FlickrRequestsAndResponses.editPhoto(
                CommonVars.picID[_selectedIndexList[i]],
                true,
                CommonVars.titleCamera[_selectedIndexList[i]]);
          }
        }
      }
      if (destination == CommonVars.private) {
        //here we need to set the privacy of this to private

        for (int i = 0; i < _selectedIndexList.length; i++) {
          if (!CommonVars.privateList
              .contains(CommonVars.imageList[_selectedIndexList[i]])) {
            CommonVars.privateList
                .add(CommonVars.imageList[_selectedIndexList[i]]);

            if (CommonVars.publicList
                .contains(CommonVars.imageList[_selectedIndexList[i]])) {
              CommonVars.publicList
                  .remove(CommonVars.imageList[_selectedIndexList[i]]);

              print("removing from public");
            }

            FlickrRequestsAndResponses.editPhoto(
                CommonVars.picID[_selectedIndexList[i]],
                false,
                CommonVars.titleCamera[_selectedIndexList[i]]);
          }
        }
      }
    });
  }

  void _changeSelection({bool enable, int index}) {
    _selectionMode = enable;
    //_selectedIndexList.add(index);
    if (index == -1) {
      _selectedIndexList.clear();
    }
  }

  Widget _createBody() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      primary: false,
      itemCount: imageUrlList.length,
      itemBuilder: (BuildContext context, int index) {
        return getGridTile(index);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.count(1, 1),
      padding: const EdgeInsets.all(4.0),
    );
  }

  GridTile getGridTile(int index) {
    if (_selectionMode) {
      return GridTile(
          header: GridTileBar(
            leading: Icon(
              _selectedIndexList.contains(index)
                  ? Icons.check_circle_outline
                  : Icons.radio_button_unchecked,
              color: _selectedIndexList.contains(index)
                  ? Colors.green
                  : Colors.black,
            ),
          ),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[50], width: 30.0)),
              child: Image.network(
                imageUrlList[index],
                fit: BoxFit.cover,
              ),
            ),
            onLongPress: () {
              setState(() {
                _changeSelection(enable: false, index: -1);
                tapped = !tapped;
              });
            },
            onTap: () {
              setState(() {
                if (_selectedIndexList.contains(index)) {
                  _selectedIndexList.remove(index);
                  _selectedImagesId.remove(picIdList[index]);
                } else {
                  _selectedIndexList.add(index);
                  _selectedImagesId.add(picIdList[index]);
                }
              });
            },
          ));
    } else {
      return GridTile(
        child: InkResponse(
          child: Image.network(
            imageUrlList[index],
            fit: BoxFit.cover,
          ),
          onLongPress: () {
            setState(() {
              _changeSelection(enable: true, index: index);
              tapped = !tapped;
            });
          },
          onTap: () {
            // push to Explore Details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExploreDetails(
                  picId: picIdList[index],
                  userName: userNameList[index],
                  photoFile: imageUrlList[index],
                  profilePic: CommonVars.profilePhotoLink,
                  title: imagesTitleList[index],
                  favCount: favCountList[index].toString(),
                  commentNum: commetNumList[index].toString(),
                  hasPressed: false,
                  userId: CommonVars.userId,
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
