import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentsSection extends StatefulWidget {
  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  String profilePic =
      'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg';

  String userName = 'Thor Odin';
  String comment = 'This is a comment yey';
  final sendComment = TextEditingController();

  List<Widget> commentsList = [];

  void Comments() {
    commentsList.add(CommentInfo(context, profilePic, userName, comment));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Comments();
  }

  @override
  Widget build(BuildContext context) {
    Comments();
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              child: ListView.builder(
                itemCount: commentsList.length,
                itemBuilder: (context, index) => commentsList[index],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          minLines: null,
                          controller: sendComment,
                          decoration: InputDecoration(
                            //enabledBorder: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Write a comment...',
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          //send first to server then clear
                          sendComment.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CommentInfo(BuildContext context, String profilePic, String userName,
      String comment) {
    var devSize = MediaQuery.of(context).size;

    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
            radius: devSize.height * 0.04,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: devSize.height * 0.03),
                  child: Text(
                    '$userName',
                    style: TextStyle(
                        fontSize: devSize.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: devSize.height * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: devSize.width * 0.05),
                  child: Text('$comment'),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Text(
                    'Reply',
                    style: TextStyle(
                        fontSize: devSize.height * 0.02, color: Colors.black87),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
