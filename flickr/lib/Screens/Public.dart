import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'CommonFunctions.dart';
import 'CommonVars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'CameraRoll.dart';

class Public extends StatefulWidget {
  Public({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PublicState createState() => _PublicState();
}

class _PublicState extends State<Public> {
  List<String> _imageList = List();

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

    _imageList.add('https://picsum.photos/800/600/?image=280');
    _imageList.add('https://picsum.photos/800/600/?image=281');
    _imageList.add('https://picsum.photos/800/600/?image=282');
    _imageList.add('https://picsum.photos/800/600/?image=283');
    _imageList.add('https://picsum.photos/800/600/?image=284');
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
                case "Friends view":
                  print("Plssssssssssssssssssssssss");
                  print(CommonVars.friendsList);
                  return getGridTile(CommonVars.friendsList, index);
                case "Family view":
                  return getGridTile(CommonVars.familyList, index);

                default:
                  print("Item count imGE VVIEW is ");
                  print(returnItemCount());
                  return getGridTile(_imageList, index);
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
          onLongPress: () {
            // setState(() {
            // //  _changeSelection(enable: true, index: index);
            //  // tapped = !tapped;
            // });
          },
        ),
      );
    }
  }

  int returnItemCount() {
    print("****************$buttonText");
    if (buttonText == "Public view")
      return CommonVars.publicList.length;
    else if (buttonText == "Family view")
      return CommonVars.familyList.length;
    else if (buttonText == "Friends view")
      return CommonVars.friendsList.length;
    else
      return _imageList.length;
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
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {
                      //_volume += 10;
                      if (_selectedIndexList.isNotEmpty)
                        CommonFunctions().showAlertDialog(
                            context, _imageList[_selectedIndexList[0]]);
                      print('Increase volume by 10');
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {
                      //_volume += 10;
                      if (_selectedIndexList.isNotEmpty) {
                        print(_selectedIndexList);

                        for (int i = 0; i < _selectedIndexList.length; i++) {
                          print("Selected Image:$_selectedIndexList");
                          print("Image Image:$_imageList");

                          _imageList.removeAt(_selectedIndexList[i]);
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

  Widget OverLay2(BuildContext context) {
    var devSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ButtonBar(
              buttonTextTheme: ButtonTextTheme.accent,
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.share_sharp),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {
                      //_volume += 10;
                      if (_selectedIndexList.isNotEmpty)
                        CommonFunctions().showAlertDialog(
                            context, _imageList[_selectedIndexList[0]]);
                      print('Increase volume by 10');
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {
                      //_volume += 10;
                      if (_selectedIndexList.isNotEmpty) {
                        print(_selectedIndexList);

                        for (int i = 0; i < _selectedIndexList.length; i++) {
                          print("Selected Image:$_selectedIndexList");
                          print("Image Image:$_imageList");

                          _imageList.removeAt(_selectedIndexList[i]);
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
      print(destination);
    });
  }

  Widget customisedBottomSheet(BuildContext context) {
    double deviceSizeHeight = MediaQuery.of(context).size.height;
    double deviceSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceSizeWidth * .6,
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
                child: Text("Friends view", style: TextStyle(fontSize: 20)),

                onPressed: () {
                  setState(() {
                    buttonText = "Friends view";
                  });
                  Navigator.pop(context);
                },
              ),
              RawMaterialButton(
                //    constraints: BoxConstraints.tight(Size(80, 80)),
                child: Text("Family view", style: TextStyle(fontSize: 20)),

                onPressed: () {
                  setState(() {
                    buttonText = "Family view";
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
