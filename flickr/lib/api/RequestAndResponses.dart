import 'dart:ui';
import 'dart:convert';
import 'package:flickr/Components/FavoritesSection.dart';
import 'package:http/http.dart' as http;
import '../Essentials/CommonVars.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flickr/Models/Photos.dart';
import 'package:flickr/Models/PictureFavorites.dart';
import 'package:flickr/Models/PictureComments.dart';
import 'package:flickr/Models/AboutPhotoModel.dart';

class FlickrRequestsAndResponses {
  static final String baseURL =
      'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';
  static Future<http.Response> logIn(final email, final password) async {
    const String baseURL = 'https://api.qasaqees.tech/register/logIn';

    var jso = {
      "email": "${email.text}",
      "password": "${password.text}",
    };
    var url = '$baseURL/register/logIn';
    var response = await http.post(
      Uri.parse(baseURL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(jso),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  static Future<http.Response> changePassword(
      final newPasswordController, final oldPasswordController) async {
    var url = "https://api.qasaqees.tech/register/changePassword";

    var jso = {
      'newPass': '${newPasswordController.text}',
      'oldPass': '${oldPasswordController.text}'
    };
    print("heeeh");
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwYjYxMzIxYWZjNDFjMDAxMjJlZGI5NSIsImlhdCI6MTYyMjU4MjIwNywiZXhwIjoxNjIyNjY4NjA3fQ.nCb-Mk9kuyN4cvBsnFUewBhVLAV7TTZtfrVHBSm4_Oc'
      },
      body: jsonEncode(jso),
    );

    print('Response1 status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  static Future<int> getUserID() async {
    // const String baseURL =
    //     'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';

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
    // const String baseURL =
    //     'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';

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
    // const String baseURL =
    //     'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';
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

/****************************************************************************/
  static Future<int> signOutRequest() async {
    var urll = 'https://api.qasaqees.tech';
    var url = '$urll/register/logOut';

    var response = await http.post(Uri.parse(url), headers: {
      "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode;
  }

/**************************************************************************/

  static Future<int> SignupRequests(
      final contextCon,
      final passwordController,
      final emailController,
      final firstNameController,
      final secondNameController,
      final ageController) async {
    var urll = 'https://api.qasaqees.tech';
    var url = '$urll/register/signUp';

    final bodyy = {
      "email": "${emailController.text}",
      "password": "${passwordController.text}",
      "firstName": "${firstNameController.text}",
      "lastName": "${secondNameController.text}",
      "age": "${ageController.text}",
    };

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(bodyy));

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
        var urll = 'https://api.qasaqees.tech';
        var url = '$urll/register/signUpWithFacebook';

        final bodyy = {
          "loginType": "Facebook",
          "accessToken": "${accessToken.token}",
        };
        var response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(bodyy),
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

  static Future<List<Photos>> GetExplore() async {
//5349b4ddd2781d08c09890f4
    var tempBaseURL =
        'https://9d3dd47b-be87-4e56-a7c3-be413e406700.mock.pstmn.io';

    var urll = '$tempBaseURL/photo/explore';

    var response = await http.get(
      Uri.parse(urll),
    );
    if (response.statusCode == 200) {
      print("resposed success explore");

      final photos = json.decode(response.body);

      List<Photos> vo = [];
      for (var i in photos['photos']) {
        vo.add(Photos.fromJson(i));
      }

      print('3ada');
      return vo;
    } else {
      print("responsed failure explore");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future AddToFavorite(
      /*String Authorization,*/ String photoIDFaved) async {
//5349b4ddd2781d08c09890f4

    var tempBaseURL =
        'https://9d3dd47b-be87-4e56-a7c3-be413e406700.mock.pstmn.io';

    var url = '$tempBaseURL/photo/addToFavorites';
    var response = await http.post(Uri.parse(url),
        body: {'photoId': '$photoIDFaved'},
        headers: {'Authorization': 'Bearer asdasdkasdliuaslidas'});

    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("resposed success Favorited a pic");
    } else {
      print("responsed failure Favorited a pic");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Fav');
    }
  }

  static Future<List<PictureFavorites>> GetFavoiteUsers(String picId) async {
//5349b4ddd2781d08c09890f4
    var tempBaseURL =
        'https://9d3dd47b-be87-4e56-a7c3-be413e406700.mock.pstmn.io';

    var urll = '$tempBaseURL/photo/whoFavortied/:$picId';
    //picid 60953562224d432a505e8d07

    var response = await http.get(Uri.parse(urll),
        headers: {'Authorization': 'Bearer asdasdkasdliuaslidas'});

    if (response.statusCode == 200) {
      print("resposed success favorite dudes");

      final favorites = json.decode(response.body);

      List<PictureFavorites> vo = [];
      for (var i in favorites['user']) {
        vo.add(PictureFavorites.fromJson(i));
      }

      print('3ada');
      return vo;
    } else {
      print("resposed failure favorite dudes");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future AddComment(String picId, String userComment) async {
//5349b4ddd2781d08c09890f4

    var tempBaseURL =
        'https://9d3dd47b-be87-4e56-a7c3-be413e406700.mock.pstmn.io';

    var urll = '$tempBaseURL/photo/:$picId/comment';
    //picid 60953562224d432a505e8d07

    var response =
        await http.post(Uri.parse(urll), body: {'comment': '$userComment'});

    if (response.statusCode == 200) {
      print("resposed success Commented Awesome");
    } else {
      print("resposed failure favorite dudes");

      throw Exception('Failed to load album');
    }
  }

  //comment photo id 5349b4ddd2781d08c09890f4
  static Future<List<PictureComments>> GetComments(String picId) async {
//5349b4ddd2781d08c09890f4
    var tempBaseURL =
        'https://9d3dd47b-be87-4e56-a7c3-be413e406700.mock.pstmn.io';

    var urll = '$tempBaseURL/photo/getComments';

    var response =
        await http.post(Uri.parse(urll), body: {"photoId": '$picId'});

    if (response.statusCode == 200) {
      print("resposed success Comments");

      final CommentList = json.decode(response.body);

      List<PictureComments> vo = [];
      for (var i in CommentList['comments']) {
        vo.add(PictureComments.fromJson(i));
      }

      print('3ada');
      return vo;
    } else {
      print("resposed failure Comments");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Comments');
    }
  }

  static Future<AboutPhotoModel> GetaboutPhoto(String picId) async {
//5349b4ddd2781d08c09890f4
    var tempBaseURL =
        'https://9d3dd47b-be87-4e56-a7c3-be413e406700.mock.pstmn.io';

    var urll = '$tempBaseURL/photo/getDetails/';
    //picid 5349b4ddd2781d08c09890f4

    var response = await http.post(Uri.parse(urll),
        headers: {'Authorization': 'Bearer asdasdkasdliuaslidas'},
        body: {'photoId': '$picId'});

    if (response.statusCode == 200) {
      print("resposed success fetched info of the pic");

      final aboutPic = json.decode(response.body);

      AboutPhotoModel vo = AboutPhotoModel.fromJson(aboutPic);

      print(vo.title);
      print('3ada');
      return vo;
    } else {
      print("resposed failure info of the pic");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load info of the pic');
    }
  }
}
