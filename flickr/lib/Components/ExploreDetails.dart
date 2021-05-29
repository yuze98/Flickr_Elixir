import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class ExploreDetails extends StatefulWidget {
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
      // builder: BotToastInit(),
      // navigatorObservers: [BotToastNavigatorObserver()],
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg',
                    //'https://pyxis.nymag.com/v1/imgs/7ca/881/7f727ef8d29529b66c4b8866ce9fe3a605-01-thor-ragnarok.rsquare.w700.jpg',
                  ),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),
            ),
            // OverLay(context),

            GestureDetector(
              onTap: () {
                print(tapped);
                setState(() {
                  if (tapped) {
                    //OverLay(context);
                  }
                  tapped = !tapped;
                });
              },
            ),

            AnimatedOpacity(
                opacity: tapped ? 1.0 : 0.0,
                duration: Duration(
                  milliseconds: 250,
                ),
                child: OverLay(context)),
          ],
        ),
      ),
    );
  }

  Widget OverLay(BuildContext context) {
    var devSize = MediaQuery.of(context).size;
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Color.fromRGBO(200, 2, 1, 0.1),
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
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.grey,
                  ),
                  tooltip: 'Share it with friends',
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.grey,
                  ),
                  tooltip: 'info about this image',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
