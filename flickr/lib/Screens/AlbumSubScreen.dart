import 'dart:io';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flickr/Models/GetAlbumMedia.dart';
import 'package:image_picker/image_picker.dart';

class AlbumSubScreen extends StatefulWidget {
  AlbumSubScreen(
      {this.receivedAlbumID,
      this.receivedAlbumName,
      this.receivedNumberOfPhotos});
  // List of images and add it in the initializer
  final String receivedAlbumID;
  final String receivedAlbumName;
  final int receivedNumberOfPhotos;

  @override
  _AlbumSubScreenState createState() => _AlbumSubScreenState();
}

class _AlbumSubScreenState extends State<AlbumSubScreen> {
  String albumID;
  String albumName;
  int numberOfPhotos;
  Future<List<GetAlbumMediaModel>> listOfAlbumMedia;

  List<String> listOfImages = [];

  List<int> _selectedIndexList = [];
  bool _selectionMode = false;

  @override
  void initState() {
    super.initState();
    albumID = widget.receivedAlbumID;
    albumName = widget.receivedAlbumName;
    numberOfPhotos = widget.receivedNumberOfPhotos;

    listOfAlbumMedia = FlickrRequestsAndResponses.GetAlbumMedia(albumID);
    // Get list of images
  }

  PickedFile coverPhotoFile;

  static const List<String> menu = <String>['Rename', 'Edit', 'Delete'];

  @override
  Widget build(BuildContext context) {
    String numberOfPhotosString = numberOfPhotos > 1
        ? numberOfPhotos.toString() + ' photos'
        : numberOfPhotos.toString() + ' photo';
    double deviceSizewidth = MediaQuery.of(context).size.width;
    double deviceSizeheight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                      PopupMenuButton(
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
                      ),
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
          body: FutureBuilder<List<GetAlbumMediaModel>>(
            future: listOfAlbumMedia,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<GetAlbumMediaModel> data = snapshot.data;

                for (var i in data) {
                  listOfImages.add(
                    i.url,
                  );
                }
                return _createBody();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
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
                    print(newAlbumName);
                    // TODO Request change album title
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
      // TODO Popup with a text field to enter name then save or cancel option
      // Change the name everywhere
    } else if (destination == 'Edit') {
      // TODO go to a new page like select
    } else if (destination == 'Delete') {
      // TODO Popup with are you sure you to delete and cancel and delete button
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
    print(destination);
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
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      primary: false,
      itemCount: listOfImages.length,
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
                listOfImages[index],
                fit: BoxFit.cover,
              ),
            ),
            onLongPress: () {
              setState(() {
                _changeSelection(enable: false, index: -1);
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
            listOfImages[index],
            fit: BoxFit.cover,
          ),
          onLongPress: () {
            setState(() {
              _changeSelection(enable: true, index: index);
            });
          },
        ),
      );
    }
  }
}
