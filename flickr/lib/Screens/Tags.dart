import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tags extends StatefulWidget {
  @override
  _Tags createState() => _Tags();
}

class _Tags extends State<Tags> {
  // This widget is the root of your application.
  final List<String> tags = <String>[];

  final tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
        resizeToAvoidBottomInset: false, //new line

        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Image Details ',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: deviceSizeheight * .1,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  deviceSizewidth * 0.06,
                  deviceSizeheight * 0.01,
                  deviceSizewidth * 0.06,
                  deviceSizeheight * 0.01),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: tagController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            for (var i = 0; i < tags.length; i++) {
                              if (tags[i].toLowerCase() ==
                                  tagController.text.toLowerCase()) {
                                print('Using loop: ${tagController.text}');

                                // Found the person, stop the loop
                                return;
                              }
                            }
                            CommonVars.tags += tagController.text + ",";
                            tags.insert(0, tagController.text);
                          },
                        );
                      },
                      icon: Icon(Icons.add),
                    ),
                    filled: true,
                    hintText: 'Tag',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: tags.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2),
                      color: Colors.transparent,
                      child: Center(
                          child: Text(
                        '${tags[index]} ',
                        style: TextStyle(fontSize: 18),
                      )),
                    );
                  }),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
