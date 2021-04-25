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
    return MaterialApp(
      //  title: 'Flickr',
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Swiper(
          pagination: SwiperPagination(),
          itemCount: MyImage.length,
          itemBuilder: (context, index) {
            return Image.network(
              MyImage[index],
              fit: BoxFit.cover,
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          icon: const Icon(Icons.access_time),
          label: const Text('Snap'),
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.pushNamed(context, '/third');
          },
        ),
      ),
    );
  }
}
