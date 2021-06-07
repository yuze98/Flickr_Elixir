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
import 'package:flickr/Models/PhotoStreamModel.dart';

class SubPhotoStream extends StatefulWidget {
  SubPhotoStream({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SubPhotoStreamState createState() => _SubPhotoStreamState();
}

class _SubPhotoStreamState extends State<SubPhotoStream> {
  List<int> _selectedIndexList = List();
  bool _selectionMode = false;
  bool tapped = false;

  List<String> _selectedImagesId = [];

  Future<List<PhotoStreamModel>> cameraRoll;
  void RollState() {
    cameraRoll =
        FlickrRequestsAndResponses.getPhotoStream(CommonVars.otherUserId);
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

    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          FutureBuilder<List<PhotoStreamModel>>(
            future: cameraRoll,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PhotoStreamModel> data = snapshot.data;
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
          ),
        ],
      )),
    );
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
        ),
      );
    } else {
      return GridTile(
        child: InkResponse(
          child: Image.network(
            CommonVars.imageList[index],
            fit: BoxFit.cover,
          ),
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
}
