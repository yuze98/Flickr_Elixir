import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../Essentials/CommonVars.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final myImage = [
    'images/photo1.jpg',
    'images/photo2.jpg',
    'images/photo3.jpg',
    'images/photo4.jpg'
  ];
  final firstTitles = [
    'Powerful',
    'Keep your memories safe',
    'Oragnisation simplified',
    'Sharing made easy',
  ];
  final secondTitles = [
    'Save all of your photos and videos in on place.',
    'Your uploaded photos stay private until you choose to share them.',
    'Search, edit and organise in seconds.',
    'Share with friends, family and the world.'
  ];

  int index2 = 0;

  @override
  Widget build(BuildContext context) {
    double deviceSize = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.height;
    // s='step 1';
    return MaterialApp(
      //  title: 'Flickr',
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Swiper(
          pagination: SwiperPagination(
            margin: EdgeInsetsDirectional.only(bottom: deviceSize * .20),
          ),
          onTap: (int index) {
            setState(() {
              index2 += 2;
              if (index2 == 5) index2 = 0;
            });
          },
          itemCount: myImage.length,
          itemBuilder: (context, index) {
            //s=mesgs[index];
            return Image.asset(
              myImage[index],
              fit: BoxFit.cover,
            );
          },
          onIndexChanged: (int index) {
            setState(() {
              index2 = index;
            });
          },
        ),
        floatingActionButton: Center(
          child: Column(
            children: [
              SafeArea(
                left: true,
                top: true,
                right: true,
                bottom: true,
                minimum: EdgeInsets.only(top: deviceSize * .25),
                child: Text(
                  'flickr',
                  style: TextStyle(
                    fontSize: deviceSizewidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                // width: 300 ,
                child: Padding(
                  padding: EdgeInsets.only(top: deviceSize * .15),
                  child: Text(
                    firstTitles[index2],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: deviceSize * .05,
                  padding: EdgeInsets.only(right: 10, left: 40, top: 10),
                  width: deviceSizewidth,
                  child: Text(
                    secondTitles[index2],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: deviceSize * .032, top: deviceSize * .30),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          right: deviceSizewidth * .05,
                          left: deviceSizewidth * .05),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white,
                              width: 2,
                              style: BorderStyle.solid)),

                      color: Colors.transparent,
                      splashColor: Colors.black26,
                      child: Text(
                        'GetStarted',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      //  splashColor: Colors.black26,
                      onPressed: () {
                        print("is logged in? ${CommonVars.loggedIn}");
                        if (CommonVars.loggedIn)
                          Navigator.pushNamed(context, "UserPage");
                        else
                          Navigator.pushNamed(context, "LoginScreen");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
