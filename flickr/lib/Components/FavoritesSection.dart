import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/api/RequestAndResponses.dart';

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
  bool isFollowing = false;

  List<Widget> FollowersCard = [];

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    followersNum = await FlickrRequestsAndResponses.getFollowers(
        '5349b4ddd2781d08c09890f4');
    setState(() {
      FollowersCard.add(FollowerInfo(
          profilePic, userName, followersNum, picNum, isFollowing));
    });
  }

  @override
  Widget build(BuildContext context) {
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

  Widget FollowerInfo(String profilePic, String userName, int followersNum,
      int picNum, bool isFollowed) {
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
                onPressed: () {
                  //func follow
                  setState(() {
                    isFollowed = !isFollowed;
                    print(isFollowed);
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(isFollowed ? Icons.remove : Icons.add),
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
