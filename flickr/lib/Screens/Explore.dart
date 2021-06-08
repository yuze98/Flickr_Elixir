import 'package:flickr/Components/ExploreDetails.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Screens/UserPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'CommentsFavoritesNavigator.dart';
// import 'package:flickr/Essentials/CommonVars.dart';
// import 'package:flickr/Essentials/CommonFunctions.dart';
// import 'package:flickr/Screens/RedirectAbPage.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flickr/Models/Photos.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';

/// This screen shows all the posts
/// Allows you to preview images using [ExploreDetails]
/// Allows you to fav and comment on images

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
  List<String> userId = [];

  var scrollController = ScrollController();

  Future refreshScreen() async {
    await Future.delayed(Duration(milliseconds: 500));

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserPage(),
      ),
    );
  }

  //int count;

  @override
  void initState() {
    // TODO: implement initState

    CommonVars.count = 5;

    super.initState();
    posts = FlickrRequestsAndResponses.getExplore();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)
        CommonVars.count = CommonVars.count + 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    // posts = FlickrRequestsAndResponses.GetExplore();
    title.clear();
    favCount.clear();
    commentNum.clear();
    userSecondName.clear();
    userName.clear();
    imageList.clear();
    profileImage.clear();
    userId.clear();
    picId.clear();

    return RefreshIndicator(
      onRefresh: refreshScreen,
      child: SafeArea(
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
                  profileImage.add(i.profilePhotoUrl);
                  userSecondName.add(i.lastName);
                  title.add(i.title);
                  favCount.add(i.favoriteCount.toString());
                  commentNum.add(i.commentsNum.toString());
                  userId.add(i.userId);
                  CommonVars.hasPressed.add(false);
                }
                return ListView.builder(
                  //controller: scrollController,
                  itemCount:
                      //CommonVars.count < imageList.length
                      //     ? CommonVars.count
                      //     :
                      imageList.length, //- count,
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
              color: Colors.white.withOpacity(0.5),
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
                      hasPressed: CommonVars.hasPressed[index],
                      userId: userId[index],
                      //userId: ,
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
                    child: GestureDetector(
                      onTap: () async {
                        if (userId[index] != CommonVars.userId) {
                          String body = await FlickrRequestsAndResponses
                              .showOtherUserProfile(userId[index]);
                          Navigator.pushNamed(context, 'OtherSubProfile');
                        } else
                          Navigator.pushNamed(context, 'subProfile');
                      },
                    ),
                    backgroundImage: NetworkImage(profileImage[index]),
                    radius: 25.0,
                  ),
                  Expanded(
                    child: Padding(
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
                    color:
                        CommonVars.hasPressed[index] ? Colors.red : Colors.grey,
                  ),
                  tooltip: 'Press Favorite',
                  onPressed: () {
                    setState(
                      () {
                        CommonVars.hasPressed[index] =
                            !CommonVars.hasPressed[index];

                        if (CommonVars.hasPressed[index]) {
                          FlickrRequestsAndResponses.addToFavorite(
                              picId[index]);
                        }
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
                    '${userName[index]} ${userSecondName[index]}',
                    picId[index]),
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
