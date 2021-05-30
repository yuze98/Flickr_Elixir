import 'package:flickr/Components/ImageList.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CommentSection.dart';
import 'package:flickr/Components/CommentsFavoritesNavigator.dart';
import 'package:flickr/Essentials/CommonFunctions.dart';
import 'AboutPhoto.dart';

class ExploreDetails extends StatefulWidget {
  final String photoFile, profilePic;
  ExploreDetails({Key key, this.photoFile, this.profilePic}) : super(key: key);

  @override
  _ExploreDetailsState createState() => _ExploreDetailsState();
}

bool hasPressed = false;
bool tapped = true;

class _ExploreDetailsState extends State<ExploreDetails> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: false,
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
                color: Colors.black,
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
                    "Thor Odin",
                    style: TextStyle(
                        fontSize: devSize.height * 0.025,
                        color: Colors.white,
                        letterSpacing: devSize.width * 0.0025),
                  ),
                )
              ],
            ),
            SizedBox(
              height: devSize.height * 0.73,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Title of photo",
                style: TextStyle(fontSize: 20, color: Colors.white54),
              ),
            ),
            Divider(
              thickness: devSize.height * 0.001,
              color: Colors.grey,
            ),
            Container(
              color: Color.fromRGBO(20, 2, 1, 0.1),
              height: 0.1 * devSize.height,
              width: double.infinity,
              child: Row(
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
                              builder: (context) =>
                                  CommentsFavoritesNavigator()),
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
                                builder: (context) => AboutPhoto()));
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
