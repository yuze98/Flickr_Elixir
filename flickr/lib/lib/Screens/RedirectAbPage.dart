import 'dart:convert';
import 'package:flickr/Components/ExploreDetails.dart';
import 'package:flickr/Essentials/CommonVars.dart';
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

bool tapped = false;

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
              GestureDetector(
                child: Container(
                  height: devicesize.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(CommonVars.imageList[0]),
                      //width: 20.0,
                      //  height: devicesize.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExploreDetails(
                              profilePic: CommonVars.imageList[0],
                              photoFile: CommonVars.imageList[0],
                              userName: CommonVars.username[0],
                              title: CommonVars.titleCamera[0],
                              favCount: CommonVars.favCount[0],
                              commentNum: CommonVars.commentNum[0],
                              hasPressed: false,
                              userId: CommonVars.userID[0],
                              picId: CommonVars.picID[0]),
                        ),
                      );
                    },
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  height: devicesize.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(CommonVars.imageList[1]),
                      //width: 20.0,
                      //  height: devicesize.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExploreDetails(
                              profilePic: CommonVars.imageList[1],
                              photoFile: CommonVars.imageList[1],
                              userName: CommonVars.username[1],
                              title: CommonVars.titleCamera[1],
                              favCount: CommonVars.favCount[1],
                              commentNum: CommonVars.commentNum[1],
                              hasPressed: false,
                              userId: CommonVars.userID[1],
                              picId: CommonVars.picID[1]),
                        ),
                      );
                    },
                  );
                },
              ),
              GestureDetector(
                child: Container(
                    height: devicesize.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(CommonVars.imageList[2]),
                        //width: 20.0,
                        //  height: devicesize.height * 0.5,
                        fit: BoxFit.cover,
                      ),
                    )),
                onTap: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExploreDetails(
                              profilePic: CommonVars.imageList[2],
                              photoFile: CommonVars.imageList[2],
                              userName: CommonVars.username[2],
                              title: CommonVars.titleCamera[2],
                              favCount: CommonVars.favCount[2],
                              commentNum: CommonVars.commentNum[2],
                              hasPressed: false,
                              userId: CommonVars.userID[2],
                              picId: CommonVars.picID[2]),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
