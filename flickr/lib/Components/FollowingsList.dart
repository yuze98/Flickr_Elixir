import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Models/PictureFavorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flickr/Models/UserFollowings.dart';

/// Shows the users who someone with this @userId follow

class FollowingsList extends StatefulWidget {
  final userId;
  FollowingsList({Key key, this.userId}) : super(key: key);

  @override
  _FollowingsList createState() => _FollowingsList();
}

class _FollowingsList extends State<FollowingsList> {
  List<Widget> followersCard = [];

  Future<List<UserFollowings>> favPics;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favPics = FlickrRequestsAndResponses.getUserFollowings(
        widget.userId); //get followers
  }

  @override
  Widget build(BuildContext context) {
    //CommonVars.favoriteUsersFollow.clear();
    followersCard.clear();
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: FutureBuilder<List<UserFollowings>>(
            future: favPics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<UserFollowings> data = snapshot.data;
                int k = 0;
                for (var i in data) {
                  if (i.id != CommonVars.userId) {
                    followersCard.add(FollowerInfo(i.profilePhoto,
                        '${i.firstName} ${i.lastName}', k, i.id));
                    k++;
                  }
                }
                return ListView.builder(
                  itemCount: followersCard.length,
                  itemBuilder: (context, index) => followersCard[index],
                );
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

  Widget FollowerInfo(
      String profilePic, String userName, int index, String id) {
    var devSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: devSize.height * 0.13,
        color: Colors.lightBlue[100],
        child: Card(
          color: Colors.lightBlue[100],
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                child: GestureDetector(
                  onTap: () async {
                    String body =
                        await FlickrRequestsAndResponses.showOtherUserProfile(
                            id);
                    Navigator.pushNamed(context, 'OtherSubProfile');
                  },
                ),
                backgroundImage: NetworkImage(profilePic),
                radius: devSize.height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '$userName',
                  style: TextStyle(
                      fontSize: devSize.height * 0.025,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
