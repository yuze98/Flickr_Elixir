import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  // This widget is the root of your application.
  final OldPasswordController = TextEditingController();
  final NewPasswordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  final ConfirmPassword = TextEditingController();
  bool oldbool = false;
  bool newbool = false;
  bool confirmbool = false;
  var NewPassword;

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
          leading: Image.asset('images/flickricon.png'),
          title: Text(
            'Change Password ',
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
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Enter old Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSizewidth * .9,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: validateoldpassword,
                  controller: OldPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(25),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: 'Old Password',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Enter New Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSizewidth * .9,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: validatenewpassword,
                  controller: NewPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(25),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: 'New Password',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Confirm Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSizewidth * .9,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: validateconfirmpassword,
                  controller: ConfirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(25),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: 'Confirm Password',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceSizeheight * .15),
              child: Container(
                width: deviceSizewidth * .8,
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(deviceSizewidth * .5),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
//                      primary:
                      //                    Colors.deepOrange;

                      print('Pressed');
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  void sending() async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io//register/changePassword?newPass=${NewPasswordController.text}&oldPass=${OldPasswordController.text}';

    var response = await http.post(Uri.parse(url), body: {
      "newPass": "${NewPasswordController.text}",
      "oldPass": "${OldPasswordController.text}"
    }, headers: {
      'Authorization': 'Bearer asdasdkasdliuaslidas'
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      showAlertDialog(context, validateconfirm());
    } else {
      showAlertDialog(context, 'Enter valid parameters');
    }
  }

  String validateoldpassword(String value) {
    Pattern pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      oldbool = false;
      return 'Enter a valid Password (8 or more characters)';
    } else {
      oldbool = true;
      return null;
    }
  }

  String validatenewpassword(String value) {
    Pattern pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = new RegExp(pattern);
    NewPassword = value;
    if (!regex.hasMatch(value) || value == null) {
      oldbool = false;
      return 'Enter a valid Password (8 or more characters)';
    } else {
      oldbool = true;
      return null;
    }
  }

  String validateconfirmpassword(String value) {
    Pattern pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      oldbool = false;
      return 'Enter a valid Password (8 or more characters)';
    } else if (value == OldPasswordController.text ||
        NewPassword == OldPasswordController.text) {
      oldbool = false;
      return "New Password can't be the old password";
    } else if (value != NewPassword) {
      oldbool = false;
      return 'Unmatched Passwords! Enter it again';
    } else {
      oldbool = true;
      return null;
    }
  }

  String validateconfirm() {
    String str;
    if (!oldbool && !newbool && !confirmbool) {
      str = 'Please enter valid parameters!';
    } else {
      str = 'Password is changed successfully';
    }
    return str;
  }

  showAlertDialog(BuildContext context, String str) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (str == 'Password is changed successfully')
          Navigator.pushNamed(context, "UserPage1");
        else
          Navigator.of(context).pop();
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
}
