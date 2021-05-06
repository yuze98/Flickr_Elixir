
import 'package:flickr/Screens/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Screens/Menu Class.dart';
import 'package:flickr/Screens/SignUp.dart';
import 'package:flickr/Screens/ChangePassword.dart';


class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: userPage(),

    );
  }
}



class userPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();

}

class _UserPage extends  State<userPage> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery
        .of(context)
        .size
        .height;
    double deviceSizewidth = MediaQuery
        .of(context)
        .size
        .width;


    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,

            actions: <Widget>[
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(80, 80)),

                child: Icon(
                  Icons.photo_size_select_actual_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: RawMaterialButton(
                  constraints: BoxConstraints.tight(Size(80, 80)),

                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
              )
              , RawMaterialButton(
                constraints: BoxConstraints.tight(Size(80, 80)),

                child: Icon(
                  Icons.museum_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              ),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(80, 80)),

                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              ),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(80, 80)),

                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ],
            toolbarHeight: deviceSizeheight * .07,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 340),
            child: Container(
              child: PopupMenuButton(
                onSelected: MovingTo,
                itemBuilder: (BuildContext context) {

                  return menu.Menu.map((String s) {
                    return PopupMenuItem <String>
                      (
                      value: s,
                      child: Text(s),
                    );
                  }).toList();
                },
              ),
            ),
          )

      ),
    );
  }

  void MovingTo(String destination) {
   setState(() {
     if (destination == menu.Signout) {
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => GetStarted()),
       );}
         if (destination == menu.ChangePassword) {
       {
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => ChangePassword()),

         );
       }

       }
       print(destination);
   });


    }
  }


