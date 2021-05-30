import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'RedirectAbPage.dart';
import 'package:http/http.dart' as http;

class AboutState extends StatefulWidget {
  @override
  _AboutStateState createState() => _AboutStateState();
}

class _AboutStateState extends State<AboutState> {
  String descrip = "Add Description...";
  String email = "Add Email Address ...";
  String occupation = "Add Occupation...";
  String hometown = "Add Hometown...";
  String city = "Add Current City...";
  var result = 'Heyoo';

  void description() async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/user/about/5?userId=5349b4ddd2781d08c09890f4';

    var response = await http.get(Uri.parse(url));
    var decoded = jsonDecode(response.body)['description'];
    descrip = decoded;
    print('description is $descrip');
  }

  void emailaddress() async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/user/about/5?userId=5349b4ddd2781d08c09890f4';

    var response = await http.get(Uri.parse(url));
    var decoded = jsonDecode(response.body)['email'];
    email = decoded;
    print('email is $email');
    // if (response.statusCode == 200) {
    //   Navigator.pop(context); // pop current page
    //   Navigator.pushNamed(context, "UserPage");
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    emailaddress();
    super.initState();
  }

  Future<void> getVal(BuildContext context, String s) async {
    switch (s) {
      case 'descrip':
        {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DescripData()),
          );

          setState(() => descrip = result);
        }
        break;

        // case 'address':
        //   {
        //     result = await Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => AddressData()),
        //     );
        //   }
        // //  setState(() => address = result);

        break;

      case 'occupation':
        {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Occupation()),
          );
        }
        setState(() => occupation = result);

        break;
      case 'hometown':
        {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Hometown()),
          );
        }
        setState(() => hometown = result);

        break;

      case 'city':
        {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CurrentCity()),
          );
        }
        setState(() => city = result);

        break;

      case 'featured':
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeatPhots()),
          );
        }
        //setState(() => city = result);
        break;

      default:
        {
          //statements;
        }
        break;
    }

    print('result is');
  }

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    //emailaddress();

    return Scaffold(
      body: ListView(
        // padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  getVal(context, 'descrip');
                },
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Description: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: descrip,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  //   getVal(context, 'address');
                },
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Email address: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: email,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  getVal(context, 'occupation');
                },
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Occupation: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: occupation,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  getVal(context, 'city');
                },
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Current City: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: city,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  getVal(context, 'hometown');
                },
                child: SizedBox(
                  height: devicesize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hometown: \n ',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: hometown,
                            style: TextStyle(
                                fontSize: devicesize.width * 0.04,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  getVal(context, 'featured');
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Featured: ',
                                    style: TextStyle(
                                        fontSize: devicesize.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 230),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'images/Wanda.jpg',
                            width: devicesize.width * 0.28,
                            height: devicesize.height * 0.16,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'images/AppIcon.jpg',
                            width: devicesize.width * 0.28,
                            height: devicesize.height * 0.16,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'images/me.jpg',
                            width: devicesize.width * 0.28,
                            height: devicesize.height * 0.16,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Date joined: \n\n" 'April 2021',
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Number of Photos Uploaded: \n\n " "42",
                            style: TextStyle(
                                fontSize: devicesize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
