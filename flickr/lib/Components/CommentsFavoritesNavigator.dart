import 'package:flickr/Components/CommentSection.dart';
import 'package:flickr/Components/FavoritesSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentsFavoritesNavigator extends StatefulWidget {
  @override
  _CommentsFavoritesNavigatorState createState() =>
      _CommentsFavoritesNavigatorState();
}

class _CommentsFavoritesNavigatorState
    extends State<CommentsFavoritesNavigator> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    int commentsNum = 0;
    int FavesNum = 0;
    String photoName = "The dude's";

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "$photoName photo",
            style: TextStyle(
              fontSize: 0.03 * MediaQuery.of(context).size.height,
            ),
          ),
        ),
        body: DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool Scroll) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      //  floating: true,
                      pinned: true,
                      backgroundColor: Colors.white,
                      toolbarHeight: 0,
                      bottom: TabBar(
                        indicatorColor: Colors.grey[800],
                        unselectedLabelColor: Colors.grey[500],
                        labelColor: Colors.grey[800],
                        // These are the widgets to put in each tab in the tab bar.
                        tabs: [
                          Text(
                            "$commentsNum Faves    ",
                            style:
                                TextStyle(fontSize: deviceSize.height * 0.028),
                          ),
                          Text(
                            "    $FavesNum Comments",
                            style:
                                TextStyle(fontSize: deviceSize.height * 0.028),
                          ),
                        ],
                        isScrollable: true,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: [
                FavoritesSection(),
                CommentsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
