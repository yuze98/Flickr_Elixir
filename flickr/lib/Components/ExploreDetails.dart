import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';
import 'AboutPhoto.dart';

class ExploreDetails extends StatefulWidget {
  final String photoFile,
      profilePic,
      userName,
      title,
      commentNum,
      favCount,
      picId,
      userId;
  bool hasPressed;

  ExploreDetails(
      {Key key,
      this.picId,
      this.photoFile,
      this.profilePic,
      this.userName,
      this.title,
      this.favCount,
      this.commentNum,
      this.hasPressed,
      this.userId})
      : super(key: key);

  @override
  _ExploreDetailsState createState() => _ExploreDetailsState();
}

bool tapped = true;

class _ExploreDetailsState extends State<ExploreDetails> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.photoFile,
                  ),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  tapped = !tapped;
                });
              },
            ),
            AnimatedOpacity(
              opacity: tapped ? 1.0 : 0.0,
              duration: Duration(
                milliseconds: 250,
              ),
              child: Visibility(
                child: OverLay(context),
                visible: tapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget OverLay(BuildContext context) {
    var devSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: devSize.width * 0.05),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.profilePic),
                      radius: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: devSize.width * 0.05),
                  child: Text(
                    "${widget.userName}",
                    style: TextStyle(
                        fontSize: devSize.height * 0.025,
                        color: Colors.white,
                        letterSpacing: devSize.width * 0.0025),
                  ),
                )
              ],
            ),
            SizedBox(
              height: devSize.height * 0.7,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${widget.title}",
                style: TextStyle(fontSize: 20, color: Colors.white54),
              ),
            ),
            Divider(
              thickness: devSize.height * 0.001,
              color: Colors.grey,
            ),
            Container(
              color: Color.fromRGBO(20, 2, 1, 0.1),
              height: 0.08 * devSize.height,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: widget.hasPressed ? Colors.red : Colors.grey,
                      ),
                      tooltip: 'Press Favorite',
                      onPressed: () {
                        setState(
                          () {
                            widget.hasPressed = !widget.hasPressed;
                            FlickrRequestsAndResponses.addToFavorite(
                                widget.picId);
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: CommonFunctions().CommentsFunction(
                        context,
                        widget.commentNum,
                        widget.favCount,
                        '${widget.userName}',
                        widget.picId),
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
                            .showAlertDialog(context, widget.photoFile);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.info,
                        color: Colors.grey,
                      ),
                      tooltip: 'info about this image',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPhoto(
                                    picId: widget.picId,
                                    userId: widget.userId)));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
