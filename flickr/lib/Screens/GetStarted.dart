import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GetStarted extends StatelessWidget {
  // This widget is the root of your application.

  final MyImage = [
    'https://yemenat.net/wp-content/uploads/2015/01/30-06-13-168938822.jpg',
    'https://yemenat.net/wp-content/uploads/2015/01/30-06-13-168938822.jpg',
    'https://yemenat.net/wp-content/uploads/2015/01/30-06-13-168938822.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    var x = MediaQuery.of(context).size.height * 0.30;
    var y = MediaQuery.of(context).size;

    return MaterialApp(
      //  title: 'Flickr',
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Swiper(
          pagination: SwiperPagination(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: y.height * 0.5),
          ),
          itemCount: MyImage.length,
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Image.network(
                  MyImage[index],
                  fit: BoxFit.fill,
                ),
                Text(
                  "data$index",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FittedBox(
          fit: BoxFit.contain,
          child: FloatingActionButton.extended(
            elevation: 4.0,
            label: Text(
              'GetStarted',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {
              Navigator.pushNamed(context, 'Signup');
              print("heh");
            },
          ),
        ),
      ),
    );
  }
}
