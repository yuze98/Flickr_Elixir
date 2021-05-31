import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Essentials/CommonVars.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FlickrRequestsAndResponses {
  static Future<int> changePassword(
      final newPasswordController, final oldPasswordController) async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io//register/changePassword?newPass=${newPasswordController.text}&oldPass=${oldPasswordController.text}';

    var response = await http.post(Uri.parse(url), body: {
      "newPass": "${newPasswordController.text}",
      "oldPass": "${oldPasswordController.text}"
    }, headers: {
      'Authorization': 'Bearer asdasdkasdliuaslidas'
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode;
  }

  static Future<int> getUserID() async {
    const String baseURL =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';

    var url = '$baseURL/user/Loginauser/:5349b4ddd2781d08c09890f4';

    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followings = decoded['Following'];
    CommonVars.followings = followings.length;
    print("size is ${followings.length}");
    return followings.length;
  }

  static Future<int> getFollowings(String id) async {
    const String baseURL =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';

//5349b4ddd2781d08c09890f4
    var url = '$baseURL/user/followings/:$id';

    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followings = decoded['Following'];
    CommonVars.followings = followings.length;
    print("size is ${followings.length}");
    return followings.length;
  }

  static Future<int> getFollowers(String id) async {
    const String baseURL =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';
//5349b4ddd2781d08c09890f4
    var url = '$baseURL/user/followers/:$id';
    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followers = decoded['followers'];
    CommonVars.followers = followers.length;
    print("size is ${followers.length}");
    return followers.length;
  }

  static Future<int> SignupRequests(
      final contextCon,
      final passwordController,
      final emailController,
      final firstNameController,
      final secondNameController,
      final ageController) async {
    var url =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io//register/signUp?email=${emailController.text}&password=${passwordController.text}&firstname=${firstNameController.text}&lastname=${secondNameController.text}&age=${ageController.text}';

    var response = await http.post(
      Uri.parse(url),
      body: {
        "email": "${emailController.text}",
        "password": "${passwordController.text}",
        "firstName": "${firstNameController.text}",
        "lastName": "${secondNameController.text}",
        "age": "${ageController.text}",
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode;
  }

  static Future<int> Login(final FacebookLogin facebookSignIn) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    int statusCode = 0;

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        //sending access token to our server
        var url =
            'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io//register/signUpWithFacebook?loginType=Facebook&accessToken=$accessToken';

        var response = await http.post(
          Uri.parse(url),
          body: {
            "loginType": "Facebook",
            "accessToken": "$accessToken",
          },
        );
        print('FB Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        statusCode = response.statusCode;

        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        await facebookSignIn.logOut();
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
    return statusCode;
  }

  static Future<int> Comments(String id) async {
    const String baseURL =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';

//5349b4ddd2781d08c09890f4
    var url = '$baseURL/user/followings/:$id';

    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followings = decoded['Following'];
    CommonVars.followings = followings.length;
    print("size is ${followings.length}");
    return followings.length;
  }
}
