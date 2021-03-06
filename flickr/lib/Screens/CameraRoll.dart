import 'package:flickr/Models/CameralRollModel.dart';
import 'package:flickr/Screens/Public.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Components/ExploreDetails.dart';
import '../Essentials/CommonVars.dart';
import 'AlbumScreen.dart';



/// This displays all images inside the camera roll view in a GridView format
/// @title : the title of the cameraroll

class CameraRoll extends StatefulWidget {
  CameraRoll({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CameraRollState createState() => _CameraRollState();
}

class _CameraRollState extends State<CameraRoll> {
  List<int> _selectedIndexList = List();
  bool _selectionMode = false;
  bool tapped = false;

  List<String> _selectedImagesId = [];

  Future<List<CameraRollModel>> cameraRoll;
  void RollState() {
    cameraRoll = FlickrRequestsAndResponses.getCameraRoll();
  }

  void getData() async {
    await FlickrRequestsAndResponses.getAbout();
  }

  @override
  void initState() {
    getData();
    CommonVars.camerarollbool = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RollState();
    List<Widget> _buttons = List();
    if (_selectionMode) {
      _buttons.add(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _selectedIndexList.sort();
            print(
                'Delete ${_selectedIndexList.length} items! Index: ${_selectedIndexList.toString()}');
          }));
    }

    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          FutureBuilder<List<CameraRollModel>>(
            future: cameraRoll,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CameraRollModel> data = snapshot.data;
                CommonVars.imageList.clear();
                CommonVars.username.clear();
                CommonVars.titleCamera.clear();
                CommonVars.favCount.clear();
                CommonVars.commentNum.clear();
                CommonVars.hasPressedCamera.clear();
                CommonVars.userID.clear();
                CommonVars.picID.clear();
                for (var i in data) {
                  CommonVars.imageList.add(i.url);
                  CommonVars.hasPressedCamera.add(false);
                  CommonVars.username.add("${i.firstName} ${i.lastName}");
                  CommonVars.titleCamera.add(i.title);
                  CommonVars.favCount.add(i.favoriteCount.toString());
                  CommonVars.commentNum.add(i.commentsNum.toString());
                  CommonVars.userID.add(i.userID);
                  CommonVars.picID.add(i.pictureID);
                  CommonVars.isPublic = i.isPublic;
                }

                //  CommonVars.isPublic = i.isPublic;
                return _createBody();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
          // _createBody(),
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
      )),
    );
  }

  void _changeSelection({bool enable, int index}) {
    _selectionMode = enable;
    // _selectedIndexList.add(index);
    if (index == -1) {
      _selectedIndexList.clear();
    }
  }

  Widget _createBody() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 4.0,
      primary: false,
      itemCount: CommonVars.imageList.length,
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
                  border: Border.all(color: Colors.blue[50], width: 30)),
              child: Image.network(
                CommonVars.imageList[index],
                //fit: BoxFit.cover,
                width: 100,
                height: 100,
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
                  _selectedImagesId.remove(CommonVars.picID[index]);
                } else {
                  _selectedIndexList.add(index);
                  _selectedImagesId.add(CommonVars.picID[index]);
                }
              });
            },
          ));
    } else {
      return GridTile(
        child: InkResponse(
          child: Image.network(
            CommonVars.imageList[index],
            fit: BoxFit.cover,
          ),
          onLongPress: () {
            setState(() {
              _changeSelection(enable: true, index: index);
              tapped = !tapped;
            });
          },
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExploreDetails(
                          photoFile: CommonVars.imageList[index],
                          profilePic: CommonVars.profilePhotoLink,
                          userName: CommonVars.username[index],
                          title: CommonVars.titleCamera[index],
                          favCount: CommonVars.favCount[index],
                          commentNum: CommonVars.commentNum[index],
                          hasPressed: CommonVars.hasPressedCamera[index],
                          userId: CommonVars.userID[index],
                          picId: CommonVars.picID[index],
                        )));
          },
        ),
      );
    }
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
                    setState(() {
                      //_volume += 10;
                      if (_selectedIndexList.isNotEmpty)
                        CommonFunctions().showAlertDialog(context,
                            CommonVars.imageList[_selectedIndexList[0]]);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete Selected Items',
                  onPressed: () {
                    setState(() {
                      //_volume += 10;
                      if (_selectedIndexList.isNotEmpty) {
                        for (int i = 0; i < _selectedIndexList.length; i++) {
                          CommonVars.imageList.removeAt(i);

                          FlickrRequestsAndResponses.deletePicture(
                              _selectedImagesId[i]);
                        }

                        _selectedIndexList.clear();
                      }
                    });
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
                        for (int j = 0; j < CommonVars.picID.length; j++) {
                          if (_selectedImagesId[i] == CommonVars.picID[j]) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumScreen(
                                  receivedPicId: _selectedImagesId[i],
                                  receivedUserId: CommonVars.userId,
                                ),
                              ),
                            );
                          }
                        }
                      }
                    }
                  },
                ),
                PopupMenuButton(
                  onSelected: movingTo,
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
}
