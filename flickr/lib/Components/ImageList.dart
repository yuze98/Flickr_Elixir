import 'package:flickr/Components/ExploreDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CommentsFavoritesNavigator.dart';
import 'package:flickr/Essentials/CommonVars.dart';

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final List<String> imageList = [
    'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg',
    'https://pyxis.nymag.com/v1/imgs/7ca/881/7f727ef8d29529b66c4b8866ce9fe3a605-01-thor-ragnarok.rsquare.w700.jpg',
    'https://i.guim.co.uk/img/media/e5da92e4397a66d9771ca1ef4d0d8eb0847eda85/0_16_1920_1152/master/1920.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1d61ca60204a01b684eb2ec8213986e5'
  ];
  final List<String> profileImage = [
    'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg',
    'https://pyxis.nymag.com/v1/imgs/7ca/881/7f727ef8d29529b66c4b8866ce9fe3a605-01-thor-ragnarok.rsquare.w700.jpg',
    'https://i.guim.co.uk/img/media/e5da92e4397a66d9771ca1ef4d0d8eb0847eda85/0_16_1920_1152/master/1920.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1d61ca60204a01b684eb2ec8213986e5'
  ];
  String userFav1 = "fathy";
  String userFav2 = "youssef";
  int favCount = 100;
  String userComment = "mohamed ismail";
  String Comment = "eh el 7alawa dih";
  String userName = "yuze";
  String title = "gamed fash5";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
              child: ListView.builder(
        itemCount: imageList.length,
        itemBuilder: (context, index) => OuterInfo(context, index),
      )

              //child: OuterInfo(context, 1),
              )),
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
                          "$userName ",
                          style: TextStyle(
                            fontSize: devSize.height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$title",
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
                    showAlertDialog(context, index);
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
                    child: Text('$userFav1, $userFav2 and $favCount faved',
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
                    '$userComment and $Comment',
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

  showAlertDialog(BuildContext context, int index) {
    // Create button
    Widget okButton = Row(
      children: <Widget>[
        TextButton(
          child: Text(
            "Share with friends",
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.025),
          ),
          onPressed: () {
            //share function
          },
        ),
      ],
    );

    AlertDialog alert = AlertDialog(
      title: Text("Share this photo"),
      content: Image.network(imageList[index]),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
