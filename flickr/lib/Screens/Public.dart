import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flickr/Components/ExploreDetails.dart';

class Public extends StatefulWidget {
  Public({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PublicState createState() => _PublicState();
}

class _PublicState extends State<Public> {
//  List<String> CommonVars.imageList = List();

  List<int> _selectedIndexList = List();
  bool _selectionMode = false;
  bool tapped = false;
  var buttonText = "Privacy";
  List<String> result;
  int listLength;

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

  @override
  void initState() {
    super.initState();
  }

  void _changeSelection({bool enable, int index}) {
    _selectionMode = enable;
    _selectedIndexList.add(index);
    if (index == -1) {
      _selectedIndexList.clear();
    }
  }

  Widget _createBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            primary: false,
            itemCount: returnItemCount(),
            itemBuilder: (BuildContext context, int index) {
              switch (buttonText) {
                case "Public view":
                  return getGridTile(CommonVars.publicList, index);
                case "Private view":
                  return getGridTile(CommonVars.privateList, index);

                default:
                  return getGridTile(CommonVars.imageList, index);
              }
            },
            staggeredTileBuilder: (int index) => StaggeredTile.count(1, 1),
            padding: const EdgeInsets.all(4.0),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text(buttonText),
                color: Colors.blue,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: ((builder) => customisedBottomSheet(context)));
                  // To do
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  GridTile getGridTile(List imageType, int index) {
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
                imageType[index],
                fit: BoxFit.cover,
              ),
            ),
            onLongPress: () {
              //  setState(() {
              //  _changeSelection(enable: false, index: -1);
              // tapped = !tapped;
              //   },
              //  );
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
            imageType[index],
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExploreDetails(
                          photoFile: imageType[index],
                          profilePic: imageType[index],
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

  int returnItemCount() {
    if (buttonText == "Public view")
      return CommonVars.publicList.length;
    else if (buttonText == "Private view")
      return CommonVars.privateList.length;
    else
      return CommonVars.imageList.length;
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
                  tooltip: 'Share with friends',
                  onPressed: () {
                    setState(() {
                      if (_selectedIndexList.isNotEmpty)
                        CommonFunctions().showAlertDialog(context,
                            CommonVars.imageList[_selectedIndexList[0]]);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete picture',
                  onPressed: () {
                    setState(() {
                      //_volume += 10;
                      if (_selectedIndexList.isNotEmpty) {
                        for (int i = 0; i < _selectedIndexList.length; i++) {
                          CommonVars.imageList.removeAt(_selectedIndexList[i]);
                        }
                        _selectedIndexList.clear();
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
      if (destination == CommonVars.signOut) {
        launch('https://www.flickr.com/help/terms');
      }
      if (destination == CommonVars.changePassword) {
        {
          launch('https://www.flickr.com/help/terms');
        }
      }
      if (destination == CommonVars.about) {
        launch('https://www.flickr.com/about');
      }
      if (destination == CommonVars.help) {
        launch('https://www.flickr.com/help/terms');
      }
    });
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
          SizedBox(height: deviceSizeHeight * .04),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                //   constraints: BoxConstraints.tight(Size(80, 80)),
                child: Text("Public view", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  setState(() {
                    buttonText = "Public view";
                    returnItemCount();
                  });
                  Navigator.pop(context);
                },
              ),
              // SizedBox(
              //   width: 20,
              // ),
              RawMaterialButton(
                //    constraints: BoxConstraints.tight(Size(80, 80)),
                child: Text("Private view", style: TextStyle(fontSize: 20)),

                onPressed: () {
                  setState(() {
                    buttonText = "Private view";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
