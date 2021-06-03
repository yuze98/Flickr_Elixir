import 'dart:ui';
import 'dart:convert';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'CameraRoll.dart';
import 'RedirectAbPage.dart';
import 'package:http/http.dart' as http;
import '../Essentials/CommonVars.dart';

class AboutState extends StatefulWidget {
  @override
  _AboutStateState createState() => _AboutStateState();
}

class _AboutStateState extends State<AboutState> {
  var result = 'Heyoo';

  void AboutAPI() async {
    await FlickrRequestsAndResponses.GetAbout();
  }

  @override
  void initState() {
    // TODO: implement initState
    AboutAPI();
    super.initState();
  }

  Future<void> getVal(BuildContext context, String s) async {
    switch (s) {
      case 'descrip':
        {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DescripData()),
          );

          setState(() => CommonVars.description = result);
        }
        break;

        break;

      case 'occupation':
        {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Occupation()),
          );
        }
        setState(() => CommonVars.occupation = result);

        break;
      case 'hometown':
        {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Hometown()),
          );
        }
        setState(() => CommonVars.hometown = result);

        break;

      case 'city':
        {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CurrentCity()),
          );
        }
        setState(() => CommonVars.city = result);

        break;

        // case 'featured':
        //   {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => FeatPhots()),
        //     );
        //   }
        //setState(() => city = result);
        break;

      default:
        {
          //statements;
        }
        break;
    }
    await FlickrRequestsAndResponses.EditAboutInfo(
        CommonVars.occupation, CommonVars.hometown, CommonVars.city);
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
                onTap: () {
                  if (CommonVars.sameUser) getVal(context, 'descrip');
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
                            text: 'Description: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.description,
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
                            text: CommonVars.sameUser
                                ? CommonVars.email
                                : CommonVars.othersEmail,
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
                  if (CommonVars.sameUser) getVal(context, 'occupation');
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
                            text: 'Occupation: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.occupation,
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
                  if (CommonVars.sameUser) getVal(context, 'city');
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
                            text: 'Current City: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.city,
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
                  if (CommonVars.sameUser) getVal(context, 'hometown');
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
                            text: 'Hometown: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: CommonVars.hometown,
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
                  getVal(context, 'featured');
                },
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
                              CommonVars.imageList.length >= 1
                                  ? imageFeat(context, 0)
                                  : Text(""),
                              CommonVars.imageList.length >= 2
                                  ? imageFeat(context, 1)
                                  : Text(""),
                              CommonVars.imageList.length >= 3
                                  ? imageFeat(context, 2)
                                  : Text("")
                              //   child: Image.network(
                              //     CommonVars.imageList[0],
                              //     width: devicesize.width * 0.28,
                              //     height: devicesize.height * 0.16,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Image.network(
                              //     CommonVars.imageList[1],
                              //     width: devicesize.width * 0.28,
                              //     height: devicesize.height * 0.16,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Image.network(
                              //     CommonVars.imageList[2],
                              //     width: devicesize.width * 0.28,
                              //     height: devicesize.height * 0.16,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
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
                            text: CommonVars.sameUser
                                ? "Date joined: \n\n" '${CommonVars.created}'
                                : "Date joined: \n\n"
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
                            text: CommonVars.sameUser
                                ? "Number of Photos Uploaded: \n\n "
                                    "${CommonVars.numberOfPhotos}"
                                : "Number of Photos Uploaded: \n\n "
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
        CommonVars.imageList[index],
        //fit: BoxFit.cover,
        width: 100,
        height: 100,
      ),
    );
  }
}

//
