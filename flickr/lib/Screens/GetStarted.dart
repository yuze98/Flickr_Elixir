import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Getstarted(),

    );
  }
}



class Getstarted extends StatefulWidget {
  @override
  _GetstartedState createState() => _GetstartedState();




}

class _GetstartedState extends State<Getstarted> {




  final myImage = [
    'images/photo3.png','images/photo1.jpg','images/photo2.jpg'
  ];
  final mesgs=['Powerful\n','Save all of your photos and videos in one place'
    ,'Step 2','Step 3'];
  int index2=0;

  @override
  Widget build(BuildContext context) {
    double deviceSize=MediaQuery.of(context).size.height;
    // s='step 1';
    return MaterialApp(
      //  title: 'Flickr',
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Swiper(
          pagination: SwiperPagination(
            margin: EdgeInsetsDirectional.only(bottom:deviceSize*.20),
          ),
          itemCount: myImage.length,
          itemBuilder: (context, index) {
            index2=index;
            print(index2);
            //s=mesgs[index];
            return Image.asset(
              myImage[index],
              fit: BoxFit.cover,

            );
          },
          onIndexChanged: (int index)
          {
            setState(() {

            });
          },
        ),



        floatingActionButton: Column(
          children: [
            SafeArea(
              left: true,
              top: true,
              right: true,
              bottom: true,
              minimum: EdgeInsets.only(top:deviceSize*.45),
              child: Container(
                // width: 300 ,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:30),
                  child: Text(
                    mesgs[index2],

                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),
                  ),
                ),
              ),





            ),
            Container(
              // width: 300 ,
              child: Padding(
                padding: const EdgeInsets.only(bottom:120),
                child: Text(
                  mesgs[index2+1],

                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),
                ),
              ),
            ),
            Container(
              height: deviceSize*.25,
              margin: EdgeInsets.only(left: deviceSize*.032),
              child: Center(
                child: FittedBox(

                  fit: BoxFit.contain,
                  child: FloatingActionButton.extended(
                    elevation: 4.0,

                    label:  Text('GetStarted',style: TextStyle(
                      fontSize:40.0 ,
                      fontWeight: FontWeight.bold,
                    ),

                    )

                    ,
                    backgroundColor: Colors.lightBlueAccent,
                    onPressed: (

                        ) {
                      Navigator.pushNamed(context, '/third');
                      print("heh");
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
