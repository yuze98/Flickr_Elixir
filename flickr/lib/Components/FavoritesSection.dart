import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesSection extends StatefulWidget {
  @override
  _FavoritesSectionState createState() => _FavoritesSectionState();
}

class _FavoritesSectionState extends State<FavoritesSection> {
  String profilePic =
      'https://pyxis.nymag.com/v1/imgs/7ca/881/7f727ef8d29529b66c4b8866ce9fe3a605-01-thor-ragnarok.rsquare.w700.jpg';

  String userName = 'Thor';
  int picNum = 0;
  int followersNum = 0;
  bool isFollowed = false;

  List<Widget> FollowersCard = [];
  @override
  Widget build(BuildContext context) {
    Widget widgy = FollowerInfo(
        context, profilePic, userName, followersNum, picNum, isFollowed);
    FollowersCard.add(widgy);

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: ListView.builder(
            itemCount: FollowersCard.length,
            itemBuilder: (context, index) => FollowersCard[index],
          ),
        ),
      ),
    );
  }

  Widget FollowerInfo(BuildContext context, String profilePic, String userName,
      int followersNum, int picNum, bool isFollowed) {
    var devSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: devSize.height * 0.13,
        color: Colors.lightBlue[100],
        child: Card(
          color: Colors.lightBlue[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(profilePic),
                radius: devSize.height * 0.04,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$userName',
                    style: TextStyle(
                        fontSize: devSize.height * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('$picNum photos - $followersNum followers')
                ],
              ),
              OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(devSize.height * 0.05),
                ))),
                onPressed: () => {
                  //func follow
                },
                child: Row(
                  children: <Widget>[
                    !isFollowed ? Icon(Icons.add) : Icon(Icons.remove),
                    isFollowed ? Text('Follwing') : Text('Follow'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
