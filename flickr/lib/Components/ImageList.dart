import 'package:flickr/Components/ExploreDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CommentsFavoritesNavigator.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';
import 'package:flickr/Screens/RedirectAbPage.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flickr/Models/Photos.dart';

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final List<String> imageList = [
    // 'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg',
    // 'https://pyxis.nymag.com/v1/imgs/7ca/881/7f727ef8d29529b66c4b8866ce9fe3a605-01-thor-ragnarok.rsquare.w700.jpg',
    // 'https://i.guim.co.uk/img/media/e5da92e4397a66d9771ca1ef4d0d8eb0847eda85/0_16_1920_1152/master/1920.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1d61ca60204a01b684eb2ec8213986e5'
    //
  ];
  final List<String> profileImage = [
    // 'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg',
    // 'https://pyxis.nymag.com/v1/imgs/7ca/881/7f727ef8d29529b66c4b8866ce9fe3a605-01-thor-ragnarok.rsquare.w700.jpg',
    // 'https://i.guim.co.uk/img/media/e5da92e4397a66d9771ca1ef4d0d8eb0847eda85/0_16_1920_1152/master/1920.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1d61ca60204a01b684eb2ec8213986e5'
    //
  ];

  Future<List<Photos>> posts;

  // String userSecondName = "fathy";
  // String favCount = '100';
  // //String userComment = "mohamed ismail";
  // String comment = '100';
  // String userName = "yuze";
  // String title = "gamed fash5";

  List<String> title = [];
  List<String> favCount = [];
  List<String> commentNum = [];
  List<String> userSecondName = [];
  List<String> userName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posts = FlickrRequestsAndResponses.GetExplore();
  }

  // void PrepareExplore() async {
  //   posts = FlickrRequestsAndResponses.GetExplore();
  //
  //   //final List<dynamic> exploreImages = [];
  //   userName = posts.firstName;
  //   userSecondName = posts.lastName;
  //   title = posts.title;
  //   favCount = posts.favoriteCount;
  //   imageList.add(posts.url);
  // }

  @override
  Widget build(BuildContext context) {
    //posts = FlickrRequestsAndResponses.GetExplore();

    return SafeArea(
      child: Container(
        child: FutureBuilder<List<Photos>>(
          future: posts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Photos> data = snapshot.data;
              for (var i in data) {
                userName.add(i.firstName);
                imageList.add(i.url);
                profileImage.add(i.url);
                userSecondName.add(i.lastName);
                title.add(i.title);
                favCount.add(i.favoriteCount);
                commentNum.add(i.commentsNum);
                print(i.favoriteCount);

                print(i.url);
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
                      photoFile: imageList[index],
                      profilePic: profileImage[index],
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
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.comment,
                    color: Colors.grey,
                  ),
                  tooltip: 'Open comment Section',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentsFavoritesNavigator()),
                    );
                  },
                ),
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
