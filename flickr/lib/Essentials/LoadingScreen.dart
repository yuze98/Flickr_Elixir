import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitDoubleBounce(
        color: Colors.deepOrange,
        size: 100,
      ),
    ));
  }
}
