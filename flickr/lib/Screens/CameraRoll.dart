import 'package:flickr/Screens/Public.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Components/ExploreDetails.dart';
import '../Essentials/CommonVars.dart';

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

  void RollState() async {
    await FlickrRequestsAndResponses.GetCameraRoll();
  }

  @override
  void initState() {
    RollState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          _createBody(),
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
    _selectedIndexList.add(index);
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
                } else {
                  _selectedIndexList.add(index);
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
                          profilePic: CommonVars.imageList[index],
                          userName: "The Amazing 7elwa",
                          title: 'riddler',
                          favCount: '1M',
                          commentNum: '5K',
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
                      print('Increase volume by 10');
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
                        print(_selectedIndexList);

                        for (int i = 0; i < _selectedIndexList.length; i++) {
                          print("Selected Image:$_selectedIndexList");
                          print("Image Image:$CommonVars.imageList");

                          CommonVars.imageList.removeAt(_selectedIndexList[i]);
                        }
                        _selectedIndexList.clear();

                        //   _selectedIndexList.removeAt(_selectedIndexList[i]);
                        // for (var elem in _selectedIndexList) {
                        //   print(elem);
                        //   _imageList.remove(elem);
                        // }

                        //  }

                        //  tapped = !tapped;
                      }
                    });
                  },
                ),
                PopupMenuButton(
                  onSelected: movingTo,
                  color: Colors.white,
                  icon: Icon(
                    Icons.photo_album,
                    color: Colors.black,
                  ),
                  itemBuilder: (BuildContext context) {
                    return CommonVars.albums.map(
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
        // CommonVars.publicList.clear();

        for (int i = 0; i < _selectedIndexList.length; i++) {
          if (!CommonVars.publicList
              .contains(CommonVars.imageList[_selectedIndexList[i]]))
            CommonVars.publicList
                .add(CommonVars.imageList[_selectedIndexList[i]]);
        }
        print(CommonVars.publicList);
      }
      if (destination == CommonVars.friends) {
        // CommonVars.friendsList.clear();
        print("Selected index of friends is $_selectedIndexList");
        for (int i = 0; i < _selectedIndexList.length; i++) {
          if (!CommonVars.friendsList
              .contains(CommonVars.imageList[_selectedIndexList[i]]))
            CommonVars.friendsList
                .add(CommonVars.imageList[_selectedIndexList[i]]);
        }
        print(CommonVars.friendsList);
      }
      if (destination == CommonVars.family) {
        //   CommonVars.familyList.clear();
        for (int i = 0; i < _selectedIndexList.length; i++) {
          if (!CommonVars.familyList
              .contains(CommonVars.imageList[_selectedIndexList[i]]))
            CommonVars.familyList
                .add(CommonVars.imageList[_selectedIndexList[i]]);
        }
        print(CommonVars.familyList);
      }

      print(destination);
    });
  }
}
