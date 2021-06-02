import 'package:flickr/Components/ExploreDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'CommentsFavoritesNavigator.dart';
// import 'package:flickr/Essentials/CommonVars.dart';
// import 'package:flickr/Essentials/CommonFunctions.dart';
// import 'package:flickr/Screens/RedirectAbPage.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flickr/Models/Photos.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final List<String> imageList = [];
  final List<String> profileImage = [];

  Future<List<Photos>> posts;

  List<String> title = [];
  List<String> favCount = [];
  List<String> commentNum = [];
  List<String> userSecondName = [];
  List<String> userName = [];
  List<String> picId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posts = FlickrRequestsAndResponses.GetExplore();
  }

  @override
  Widget build(BuildContext context) {
    title.clear();
    favCount.clear();
    commentNum.clear();
    userSecondName.clear();
    userName.clear();
    imageList.clear();
    profileImage.clear();
    picId.clear();
    return SafeArea(
      child: Container(
        child: FutureBuilder<List<Photos>>(
          future: posts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Photos> data = snapshot.data;
              for (var i in data) {
                userName.add(i.firstName);
                picId.add(i.id);
                imageList.add(i.url);
                profileImage.add(i.url);
                userSecondName.add(i.lastName);
                title.add(i.title);
                favCount.add(i.favoriteCount.toString());
                commentNum.add(i.commentsNum.toString());
              }
              return ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) => OuterInfo(context, index),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
        // child: ListView.builder(
        //   itemCount: imageList.length,
        //   itemBuilder: (context, index) => OuterInfo(context, index),
        // ),
      ),
    );
  }

  Widget OuterInfo(BuildContext context, int index) {
    var devSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white70,
      child: Column(
        children: [
          Container(
            height: devSize.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageList[index],
                ),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExploreDetails(
                      picId: picId[index],
                      photoFile: imageList[index],
                      profilePic: profileImage[index],
                      userName: '${userName[index]} ${userSecondName[index]}',
                      title: title[index],
                      commentNum: commentNum[index].toString(),
                      favCount: favCount[index].toString(),
                    ),
                  ),
                ),
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(devSize.height * 0.01),
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileImage[index]),
                    radius: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: devSize.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userName[index]} ${userSecondName[index]}",
                          style: TextStyle(
                            fontSize: devSize.height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${title[index]}",
                          style: TextStyle(
                            fontSize: devSize.height * 0.025,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: devSize.height * 0.08,
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: devSize.height * 0.001,
            color: Colors.grey,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: hasPressed ? Colors.red : Colors.grey,
                  ),
                  tooltip: 'Press Favorite',
                  onPressed: () {
                    setState(
                      () {
                        hasPressed = !hasPressed;

                        if (hasPressed)
                          FlickrRequestsAndResponses.AddToFavorite(
                              "60953562224d432a505e8d07");
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: CommonFunctions().CommentsFunction(
                    context,
                    commentNum[index],
                    favCount[index],
                    '${userName[index]} ${userSecondName[index]}'),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.grey,
                  ),
                  tooltip: 'Share it with friends',
                  onPressed: () {
                    CommonFunctions()
                        .showAlertDialog(context, imageList[index]);
                  },
                ),
              ),
            ],
          ),
          Divider(
            thickness: devSize.height * 0.001,
            color: Colors.grey,
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  devSize.width * 0.05, devSize.height * 0.01, 0, 0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: devSize.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: devSize.width * 0.05),
                    child: Text('${favCount[index]} faved',
                        style: TextStyle(
                            fontSize: devSize.height * 0.025,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                devSize.width * 0.05, devSize.height * 0.01, 0, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.comment,
                  color: Colors.grey,
                  size: devSize.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: devSize.width * 0.05),
                  child: Text(
                    '${commentNum[index]} comments',
                    style: TextStyle(
                        fontSize: devSize.height * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: devSize.height * 0.05,
          )
        ],
      ),
    );
  }
}
