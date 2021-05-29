import 'dart:convert';

import 'About.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DescripData extends StatefulWidget {
  @override
  _DescripDataState createState() => _DescripDataState();
}

class _DescripDataState extends State<DescripData> {
  TextEditingController dataController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(
            left: 30.0,
            top: 90.0,
            right: 30.0,
          ),
          // height: 40.0,
          child: Column(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    // filled: true,
                    // border: OutlineInputBorder(),
                    hintText: 'Enter Description',
                    fillColor: Colors.white,
                  ),
                  controller: dataController,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 88.0),
                  child: ElevatedButton(
                    // textColor: Colors.white,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      sending();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sending() async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/user/about/5?userId=5349b4ddd2781d08c09890f4';

    var response = await http.get(Uri.parse(url));
    var decoded = jsonDecode(response.body)['description'];
    print('Response status: ${response.statusCode}');
    print('Response body: $decoded');

    if (response.statusCode == 200) {
      showAlertDialog(context, validateubmit(200), dataController.text);
      // Navigator.pop(context, dataController.text);
      //  print("ttttt")+
      ;
      print(dataController.text);
    } else {
      showAlertDialog(context, 'Enter valid parameters', dataController.text);
    }
  }
}

showAlertDialog(BuildContext context, String str, String controller) {
  // Create button

  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      if (str == 'Data entry successful') {
        print("success");
        print("Controller is  $controller");
        Navigator.of(context).pop();

        Navigator.pop(context, controller);
      } else {
        print("fail");

        Navigator.of(context).pop();
      }
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text(str),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String validateubmit(int value) {
  String str;
  print("Value is ");
  print(value);
  if (value != 200) {
    str = 'Enter valid parameters';
  } else {
    str = 'Data entry successful';
  }
  return str;
}

class AddressData extends StatefulWidget {
  @override
  _AddressDataState createState() => _AddressDataState();
}

class _AddressDataState extends State<AddressData> {
  TextEditingController dataController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(
            left: 30.0,
            top: 90.0,
            right: 30.0,
          ),
          // height: 40.0,
          child: Column(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    // filled: true,
                    // border: OutlineInputBorder(),
                    hintText: 'Enter address',
                    fillColor: Colors.white,
                  ),
                  controller: dataController,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 88.0),
                  child: ElevatedButton(
                    // textColor: Colors.white,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context, dataController.text);
                      print(dataController.text);
                    },
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

class Occupation extends StatefulWidget {
  @override
  _OccupationState createState() => _OccupationState();
}

class _OccupationState extends State<Occupation> {
  TextEditingController dataController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(
            left: 30.0,
            top: 90.0,
            right: 30.0,
          ),
          // height: 40.0,
          child: Column(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    // filled: true,
                    // border: OutlineInputBorder(),
                    hintText: 'Enter occupation',
                    fillColor: Colors.white,
                  ),
                  controller: dataController,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 88.0),
                  child: ElevatedButton(
                    // textColor: Colors.white,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context, dataController.text);
                      print(dataController.text);
                    },
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

class CurrentCity extends StatefulWidget {
  @override
  _CurrentCityState createState() => _CurrentCityState();
}

class _CurrentCityState extends State<CurrentCity> {
  TextEditingController dataController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(
            left: 30.0,
            top: 90.0,
            right: 30.0,
          ),
          // height: 40.0,
          child: Column(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    // filled: true,
                    // border: OutlineInputBorder(),
                    hintText: 'Enter current city',
                    fillColor: Colors.white,
                  ),
                  controller: dataController,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 88.0),
                  child: ElevatedButton(
                    // textColor: Colors.white,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context, dataController.text);
                      print(dataController.text);
                    },
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

class Hometown extends StatefulWidget {
  @override
  _HometownState createState() => _HometownState();
}

class _HometownState extends State<Hometown> {
  TextEditingController dataController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(
            left: 30.0,
            top: 90.0,
            right: 30.0,
          ),
          // height: 40.0,
          child: Column(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    // filled: true,
                    // border: OutlineInputBorder(),
                    hintText: 'Enter hometown',
                    fillColor: Colors.white,
                  ),
                  controller: dataController,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 88.0),
                  child: ElevatedButton(
                    // textColor: Colors.white,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context, dataController.text);
                      print(dataController.text);
                    },
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

class FeatPhots extends StatefulWidget {
  @override
  _FeatPhotsState createState() => _FeatPhotsState();
}

class _FeatPhotsState extends State<FeatPhots> {
  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: new Center(
          child: new ListView(
            children: [
              Image.asset(
                'images/Wanda.jpg',
                //width: 20.0,
                //  height: devicesize.height * 0.5,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/AppIcon.jpg',
                // width: 600.0,
                // height: devicesize.height * 0.5,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/me.jpg',
                // width: 600.0,
                // height: devicesize.height * 0.5,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
