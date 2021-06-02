import 'package:flickr/Models/PictureFavorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/api/RequestAndResponses.dart';

class FavoritesSection extends StatefulWidget {
  final picId;
  FavoritesSection({Key key, this.picId}) : super(key: key);

  @override
  _FavoritesSectionState createState() => _FavoritesSectionState();
}

class _FavoritesSectionState extends State<FavoritesSection> {
  List<Widget> followersCard = [];

  Future<List<PictureFavorites>> favPics;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favPics = FlickrRequestsAndResponses.GetFavoiteUsers(widget.picId);
  }

  @override
  Widget build(BuildContext context) {
    followersCard.clear();
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: FutureBuilder<List<PictureFavorites>>(
            future: favPics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PictureFavorites> data = snapshot.data;
                for (var i in data) {
                  followersCard.add(FollowerInfo(
                      i.profilePhoto,
                      '${i.firstName} ${i.lastName}',
                      i.followersNum,
                      i.photosCount,
                      i.isFollowing));
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

  Widget FollowerInfo(String profilePic, String userName, String followersNum,
      String picNum, bool isFollowed) {
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
