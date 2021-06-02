import 'dart:async';
import 'dart:io';
import 'Explore.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'SubProfile.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:convert';
import 'package:async/async.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  // This widget is the root of your application.
  PickedFile photoFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double deviceSizeheight = MediaQuery.of(context).size.height;
    double deviceSizewidth = MediaQuery.of(context).size.width;
    double buttonwidth = deviceSizewidth / 5;
    double buttonWidth = deviceSizewidth / 5;
    final ImagePicker _picker = ImagePicker();
    PickedFile _photofile;
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool Scroll) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    //  floating: true,
                    toolbarHeight: deviceSizeheight * .05,

                    backgroundColor: Colors.black,
                    bottom: TabBar(
                      indicatorColor: Colors.grey[800],
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.grey[800],

                      // These are the widgets to put in each tab in the tab bar.
                      tabs: [
                        RawMaterialButton(
                          child: Icon(
                            Icons.photo_size_select_actual_outlined,
                          ),
                        ),
                        RawMaterialButton(
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                        RawMaterialButton(
                          child: Icon(
                            Icons.museum_rounded,
                          ),
                        ),
                        RawMaterialButton(
                          child: Icon(
                            Icons.notifications,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) =>
                                  customisedBottomSheet(context)),
                            );
                          },
                          child: Icon(
                            Icons.camera_alt_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: [
                ImageList(),
                Icon(Icons.public),
                SubProfile(photoFile: photoFile),
                Icon(Icons.album_sharp),
                Icon(Icons.group),
              ]),
        ),
      ),
    );
  }

  void convertingPhoto() async {
    final bytes = await photoFile.readAsBytes();
    sending(bytes);
    print(bytes);
  }

  void sending(final bytes) async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/photo/upload?photo=$bytes&isPublic=true&title=Cairo Tower&allowCommenting=true&license=""&contentType=""&safetyOption=""&description=""';

    var response = await http.post(Uri.parse(url), body: {
      {
        "photo":
            "[255, 216, 255, 225, 1, 25, 69, 120, 105, 102, 0, 0, 77, 77, 0, 42, 0, 0, 0, 8, 0, 5, 1, 0, 0, 3, 0, 0, 0, 1, 4, 56, 0, 0, 1, 1, 0, 3, 0, 0, 0, 1, 9, 96, 0, 0, 1, 49, 0, 2, 0, 0, 0, 38, 0, 0, 0, 74, 135, 105, 0, 4, 0, 0, 0, 1, 0, 0, 0, 112, 1, 18, 0, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 65, 110, 100, 114, 111, 105, 100, 32, 82, 80, 49, 65, 46, 50, 48, 48, 55, 50, 48, 46, 48, 49, 50, 46, 65, 53, 49, 53, 70, 88, 88, 85, 52, 68, 85, 66, 49, 0, 0, 4, 144, 3, 0, 2, 0, 0, 0, 20, 0, 0, 0, 166, 146, 145, 0, 2, 0, 0, 0, 4, 55, 48, 49, 0, 144, 17, 0, 2, 0, 0, 0, 7, 0, 0, 0, 186, 146, 8, 0, 4, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 50, 48, 50, 49, 58, 48, 53, 58, 48, 55, 32, 50, 50, 58, 48, 48, 58, 48, 52, 0, 43, 48, 50, 58, 48, 48, 0, 0, 3, 1, 0, 0, 3, 0, 0, 0, 1, 4, 56, 0, 0, 1, 49, 0, 2, 0, 0, 0, 38, 0, 0, 0, 235, 1, 1, 0, 3, 0, 0, 0, 1, 9, 96, 0, 0, 0, 0, 0, 0, 65, 110, 100, 114, 111, 105, 100, 32, 82, 80, 49, 65, 46, 50, 48, 48, 55, 50, 48, 46, 48, 49, 50, 46, 65, 53, 49, 53, 70, 88, 88, 85, 52, 68, 85, 66, 49, 0]",
        "isPublic": "true",
        "title": "Cairo Tower",
        "allowCommenting": "true",
        "license": "",
        "contentType": "",
        "safetyOption": "",
        "description": "A photo of Cairo tower at the sunset"
      }
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Widget tempImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              //borderRadius: BorderRadius.all(Radius.circular(.05)),//add border radius here
              photoFile == null
                  ? AssetImage('images/photo1.jpg')
                  : FileImage(File(photoFile.path)),
          fit: BoxFit.fitHeight, //add image location here
        ),
      ),
    );
  }

  Widget customisedBottomSheet(BuildContext context) {
    double deviceSizeHeight = MediaQuery.of(context).size.height;
    double deviceSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceSizeWidth * .4,
      width: deviceSizeWidth,
//margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 40),
      child: Column(
        children: <Widget>[
          Text("Choose your photo", style: TextStyle(fontSize: 30)),
          SizedBox(height: deviceSizeHeight * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                //   constraints: BoxConstraints.tight(Size(80, 80)),
                child: Icon(Icons.camera_alt_sharp, size: 40),
                onPressed: () {
                  photoTaker(ImageSource.camera);
                },
              ),
              SizedBox(
                width: 20,
              ),
              RawMaterialButton(
                //    constraints: BoxConstraints.tight(Size(80, 80)),
                child: Icon(
                  Icons.image_rounded,
                  size: 40,
                ),
                onPressed: () {
                  print("gallery");
                  photoTaker(ImageSource.gallery);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void photoTaker(ImageSource source) async {
    final token = await _picker.getImage(source: source);
    setState(() {
      CommonVars.photoFile = token;
    });

    const String baseURL = 'https://api.qasaqees.tech/photo/upload';

    var request = http.MultipartRequest('POST', Uri.parse(baseURL));
    request.headers['Authorization'] =
        "Bearer ${CommonVars.loginRes["accessToken"]}";
    request.fields['isPublic'] = "true";
    request.fields['title'] = "Cairo Tower";
    request.fields['allowCommenting'] = "true";
    request.fields['tags'] = "kolya";
    request.fields['safetyOption'] = "";
    request.fields['description'] = "A photo of Cairo tower at the sunset";
    request.files.add(
        await http.MultipartFile.fromPath('file', CommonVars.photoFile.path));
    var res = await request.send();
    //ٍ  return res.reasonPhrase;

    print('Response22 status: ${res.statusCode}');
    var response = await http.Response.fromStream(res);

    print('Response33 body: ${response.body}');

    /*Navigator.of(context).pop();
    Navigator.pushNamed(context, "UploadDetails");
*/
  }
} //assef gedan
