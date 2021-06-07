import 'dart:ui';
import 'dart:convert';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'CameraRoll.dart';
import 'RedirectAbPage.dart';
import 'package:http/http.dart' as http;
import '../Essentials/CommonVars.dart';

class OtherUserAboutState extends StatefulWidget {
  @override
  _OtherUserAboutStateState createState() => _OtherUserAboutStateState();
}

class _OtherUserAboutStateState extends State<OtherUserAboutState> {
  var result = 'Heyoo';

  void AboutAPI() async {
    await FlickrRequestsAndResponses.showOtherUserProfile(
        CommonVars.otherUserId);
  }

  @override
  void initState() {
    // TODO: implement initState
    AboutAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    //emailaddress();

    return Scaffold(
      body: ListView(
        // padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Description: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.othersDescription,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  //   getVal(context, 'address');
                },
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Email address: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.othersEmail,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Occupation: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.othersAccupation,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Current City: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.othersCity,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hometown: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.othersHometown,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Featured: ',
                                    style: TextStyle(
                                        fontSize: devicesize.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CommonVars.camerarollbool
                        ? Row(
                            children: [
                              CommonVars.otherFeaturedPhotos.length >= 1
                                  ? imageFeat(context, 0)
                                  : Text(""),
                              CommonVars.otherFeaturedPhotos.length >= 2
                                  ? imageFeat(context, 1)
                                  : Text(""),
                              CommonVars.otherFeaturedPhotos.length >= 3
                                  ? imageFeat(context, 2)
                                  : Text("")
                            ],
                          )
                        : Text(""),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Date joined: \n\n"
                                '${CommonVars.othersCreated}',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Number of Photos Uploaded: \n\n "
                                "${CommonVars.othersNumberOfPhotos}",
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageFeat(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(
        CommonVars.otherFeaturedPhotos[index],
        width: 100,
        height: 100,
      ),
    );
  }
}

//
