import 'dart:ui';
import 'dart:convert';
import 'package:flickr/Models/CameralRollModel.dart';
import 'package:http/http.dart' as http;
import '../Essentials/CommonVars.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flickr/Models/Photos.dart';
import 'package:flickr/Models/PictureFavorites.dart';
import 'package:flickr/Models/PictureComments.dart';
import 'package:flickr/Models/AboutPhotoModel.dart';
import 'package:flickr/Models/UserFollowings.dart';
import 'package:flickr/Models/UserFollowers.dart';
import 'package:flickr/Models/GetAlbumMedia.dart';

class FlickrRequestsAndResponses {
  static final String baseURL = 'https://api.qasaqees.tech';

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

  static Future<int> SignUpFB(final FacebookLogin facebookSignIn) async {
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

  static Future<http.Response> LogInFB(
      final FacebookLogin facebookSignIn) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    int statusCode = 0;
    var response;
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
        var url = '$urll/register/loginWithFacebook';

        final bodyy = {
          "loginType": "Facebook",
          "accessToken": "${accessToken.token}",
        };

        response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(bodyy),
        );
        CommonVars.loginRes = json.decode(response.body);
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
    return response;
  }

  static Future<List<Photos>> GetExplore() async {
//5349b4ddd2781d08c09890f4

    // var tempBaseURL =
    //     'https://9d3dd47b-be87-4e56-a7c3-be413e406700.mock.pstmn.io';

    var urll = '$baseURL/photo/explore';

    var response = await http.get(
      Uri.parse(urll),
    );
    if (response.statusCode == 200) {
      print("resposed success explore");

      final photos = json.decode(response.body);
      //print(photos['photos']['']);

      List<Photos> vo = [];
      for (var i in photos['photos']) {
        vo.add(Photos.fromJson(i));
      }

      //   print('3ada');
      return vo;
    } else {
      print("responsed failure explore");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future AddToFavorite(String photoIDFaved) async {
//5349b4ddd2781d08c09890f4

    var url = '$baseURL/photo/addToFavorites';

    final bodyy = {'photoId': '$photoIDFaved'};
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

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
    var urll = '$baseURL/photo/whoFavorited/$picId';

    var response = await http.get(Uri.parse(urll), headers: {
      'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
    });

    if (response.statusCode == 200) {
      //   print("resposed success favorite dudes");

      final favorites = json.decode(response.body);

      List<PictureFavorites> vo = [];
      for (var i in favorites['user']) {
        vo.add(PictureFavorites.fromJson(i));
      }

      //print('3ada');
      return vo;
    } else {
      print("resposed failure favorite dudes");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load get favorite');
    }
  }

  static Future AddComment(String picId, String userComment) async {
//5349b4ddd2781d08c09890f4

    var urll = '$baseURL/photo/$picId/comment';
    //picid 60953562224d432a505e8d07

    var bodyy = {'comment': '$userComment'};
    var response = await http.post(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
        },
        body: jsonEncode(bodyy));

    if (response.statusCode == 200) {
      print("resposed success Commented Awesome");
    } else {
      print("resposed failure comment dudes");

      print(response.body);
      throw Exception('Failed to load album');
    }
  }

  static Future<String> GetAbout() async {
    var url = 'https://api.qasaqees.tech/user/about/60b788d18d3e8100126ed17e';

    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      print("resposed success explore");

      final about = json.decode(response.body);

      CommonVars.email = about['user']['email'];
      CommonVars.occupation = about['user']['occupation'];
      CommonVars.city = about['user']['currentCity'];
      CommonVars.hometown = about['user']['homeTown'];
      CommonVars.created = about['user']['createdAt'];
      CommonVars.numberOfPhotos = about['user']['numberOfPhotos'];
      CommonVars.coverPhotoLink = about['user']['coverPhotoUrl'];
      CommonVars.profilePhotoLink = about['user']['profilePhotoUrl'];
      CommonVars.followings = about['user']['numberOfFollowings'];
      CommonVars.followers = about['user']['numberOfFollowers'];
      // print("our link is ${CommonVars.profilePhotoLink}");

      // print("Email is");
      // print(about);
      //print(CommonVars.email);
      // print(CommonVars.numberOfPhotos);
    } else {
      print("responsed failure explore");
      // If the server did not return a 200 OK response,
      throw Exception('Failed to load album');
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  //comment photo id 5349b4ddd2781d08c09890f4
  static Future<List<PictureComments>> GetComments(String picId) async {
//5349b4ddd2781d08c09890f4

    var urll = '$baseURL/photo/getComments';

    final bodyy = {"photoId": '$picId'};

    var response = await http.post(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyy));

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
//     var tempBaseURL =
//         'https://9d3dd47b-be87-4e56-a7c3-be413e406700.mock.pstmn.io';

    var urll = '$baseURL/photo/getDetails/';
    //picid 5349b4ddd2781d08c09890f4

    final bodyy = {'photoId': '$picId'};
    var response = await http.post(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
        },
        body: jsonEncode(bodyy));

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

  static Future<List<CameraRollModel>> GetCameraRoll() async {
    var url = '$baseURL/user/cameraRoll';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      //  body: jsonEncode(body)
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final cameralist = json.decode(response.body);
      //print(photos['photos']['']);

      List<CameraRollModel> vo = [];
      for (var i in cameralist['cameraRoll']) {
        print(i);
        vo.add(CameraRollModel.fromJson(i));
      }
      print("responsed camera success cameraaa rooll");

      //   print('3ada');
      return vo;
    } else {
      print("responsed camera failure cameraaa rooll");
      // If the server did not return a 200 OK response,
      // then throw an exception.
    }
    throw Exception('Failed to load camera roll');
  }

  /*******************************************************************************/

  static Future<String> uploadImage() async {
    const String baseURL = 'https://api.qasaqees.tech/photo/upload';

    var request = http.MultipartRequest('POST', Uri.parse(baseURL));
    print(
        "our tokeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen ${CommonVars.loginRes["accessToken"]}");
    request.headers['Authorization'] =
        "Bearer ${CommonVars.loginRes["accessToken"]}";
    request.fields['isPublic'] = "true";
    request.fields['title'] =
        CommonVars.title == "" ? "profile" : CommonVars.title;
    request.fields['allowCommenting'] = "true";
    request.fields['tags'] = CommonVars.tags == "" ? "pro" : CommonVars.tags;
    request.fields['safetyOption'] = ""; //null
    request.fields['description'] =
        CommonVars.description == "" ? "pro" : CommonVars.description;
    request.files.add(
        await http.MultipartFile.fromPath('file', CommonVars.photoFile.path));
    var res = await request.send();
    //ٍ  return res.reasonPhrase;

    print('Response22 status: ${res.statusCode}');
    var response = await http.Response.fromStream(res);

    print('Response33 body: ${response.body}');
    var body = jsonDecode(response.body);
    return body["_id"];
  }

/*********************************************************************************/

  static changeCoverPhoto(String id) async {
    print("Coverrrrrrrrrrrrrrrrrrrrr");
    const String baseURL = 'https://api.qasaqees.tech';
    var urll = 'https://api.qasaqees.tech/user/editCoverPhoto';

    var body = {"photoId": id};
    var response = await http.patch(Uri.parse(urll),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
        },
        body: jsonEncode(body));
    // print(response.body);
  }

  static profileCoverPhoto(String id) async {
    print("profilleeeeeeeeeeeeeeeeeeee");
    const String baseURL = 'https://api.qasaqees.tech';
    var urll = 'https://api.qasaqees.tech/user/editProfilePhoto';

    var body = {"photoId": id};
    var response = await http.patch(Uri.parse(urll),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
        },
        body: jsonEncode(body));
    print(response.statusCode);
    // print(response.body);
  }

  static Future FollowUser(String userTobeFollowed) async {
//5349b4ddd2781d08c09890f4

    print("user id is$userTobeFollowed");

    var urll = '$baseURL/user/followUser';

    var bodyy = {'userId': userTobeFollowed};

    var response = await http.post(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
        },
        body: jsonEncode(bodyy));

    if (response.statusCode == 200) {
      print("resposed success followed a user");
    } else {
      print("resposed failure cant Follow a user");

      print(response.body);
      throw Exception('Failed to load follow');
    }
  }

  static Future AddTags(String picId, String tag) async {
//5349b4ddd2781d08c09890f4

    print("the picid tag $picId");
    var urll = '$baseURL/photo/addTags/$picId';

    var bodyy = {'tag': '$tag'};

    var response = await http.patch(
      Uri.parse(urll),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    if (response.statusCode == 200) {
      print("resposed success added tag");
    } else {
      print("resposed failure add tag");

      print(response.body);
      throw Exception('Failed to add tag');
    }
  }

  static Future EditAboutInfo(
      String occupation, String hometown, String city) async {
//5349b4ddd2781d08c09890f4

    var urll = '$baseURL/user/editInfo';

    var bodyy = {
      'occupation': occupation,
      'homeTown': hometown,
      'currentCity': city
    };
    var response = await http.patch(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
        },
        body: jsonEncode(bodyy));

    if (response.statusCode == 200) {
      print("resposed success edit about info");
    } else {
      print("resposed failure edit about info");

      print(response.body);
      throw Exception('Failed to load edit about info');
    }
  }

  static Future forgetPass(String email) async {
    var url = '$baseURL/register/forgetPassword';
    var jso = {'email': email};

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      //  headers: {"Content-Type": "application/json"},
      body: jsonEncode(jso),
    );

    if (response.statusCode == 200) {
      print("resposed success forgetpass");
    } else {
      print("resposed failure forgetpass");

      print(response.body);
      throw Exception('Failed to forgetpass');
    }

    return response;
  }

  static Future<String> showOtherUserProfile(String id) async {
    var url = 'https://api.qasaqees.tech/user/about/$id';

    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      print("resposed success explore");

      final about = json.decode(response.body);
      CommonVars.otherUserId = id;
      CommonVars.othersEmail = about['user']['email'];
      CommonVars.othersAccupation = about['user']['occupation'];
      CommonVars.othersCity = about['user']['currentCity'];
      CommonVars.othersHometown = about['user']['homeTown'];
      CommonVars.othersCreated = about['user']['createdAt'];
      CommonVars.othersNumberOfPhotos = about['user']['numberOfPhotos'];
      CommonVars.othersCoverPhotoUrl = about['user']['coverPhotoUrl'];
      CommonVars.othersProfilePhotoUrl = about['user']['profilePhotoUrl'];
      CommonVars.othersFollowings = about['user']['numberOfFollowings'];
      CommonVars.othersFollowers = about['user']['numberOfFollowers'];
    } else {
      print("responsed failure explore");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return response.body;
  }
  /*HTTP/1.1 200 OK
{
  "user": {
    "showCase": {
        "title": "Showcase",
        "photos": []
    },
    "description": "",
    "occupation": "",
    "homeTown": "",
    "currentCity": "",
    "coverPhotoUrl": "http://localhost:3000/public/images/default/8.jpeg",
    "profilePhotoUrl": "http://localhost:3000/public/images/default/8.jpeg",
    "_id": "60b5f47c2b026f150822c5fd",
    "email": "test@test.com",
    "firstName": "Abdelrahman",
    "lastName": "Shahda",
    "userName": "test",
    "age": 22,
    "createdAt": "2021-06-01T08:49:00.059Z",
    "updatedAt": "2021-06-01T11:33:15.837Z",
    "__v": 1,
    "numberOfFollowers": 0,
    "numberOfPhotos": 132,
    "id": "60b5f47c2b026f150822c5fd",
    "numberOfFollowings": 1,
    "isFollowing": false
}
}*/

  static Future<List<UserFollowings>> getUserFollowings(String userid) async {
    var urll = '$baseURL/user/followings/$userid';

    var response = await http.get(Uri.parse(urll), headers: {
      'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
    });

    if (response.statusCode == 200) {
      //   print("resposed success favorite dudes");

      final favorites = json.decode(response.body);

      List<UserFollowings> vo = [];
      for (var i in favorites['following']) {
        vo.add(UserFollowings.fromJson(i));
      }

      //print('3ada');
      return vo;
    } else {
      print("resposed failure favorite dudes");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load get favorite');
    }
  }

  static Future<List<UserFollowers>> getUserFollowers(String userid) async {
    var urll = '$baseURL/user/followers/$userid';

    var response = await http.get(Uri.parse(urll), headers: {
      'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
    });

    if (response.statusCode == 200) {
      //   print("resposed success favorite dudes");

      final favorites = json.decode(response.body);

      List<UserFollowers> vo = [];
      for (var i in favorites['followers']) {
        vo.add(UserFollowers.fromJson(i));
      }

      //print('3ada');
      return vo;
    } else {
      print("resposed failure favorite dudes");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load get favorite');
    }
  }

  static Future UnFollowUser(String userTobeUnFollowed) async {
//5349b4ddd2781d08c09890f4

    print("user id is$userTobeUnFollowed");

    var urll = '$baseURL/user/unfollowUser';

    var bodyy = {'userId': userTobeUnFollowed};

    var response = await http.post(
      Uri.parse(urll),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    if (response.statusCode == 200) {
      print("resposed success unfollowed a user");
    } else {
      print("resposed failure cant unFollow a user");

      print(response.body);
      throw Exception('Failed to load unfollow');
    }
  }

  static Future DeletePicture(String picId) async {
    var urll = '$baseURL/photo/delete/$picId';

    var bodyy = {"photoId": picId};

    var response = await http.delete(
      Uri.parse(urll),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    if (response.statusCode == 200) {
      print("resposed success Deleted photo");
    } else {
      print("resposed failure can't Delete photo");

      print(response.body);
      throw Exception('Failed to load Delete');
    }
  }

  static Future CreateAlbum(String albumTitle, String albumDescription) async {
    var url = '$baseURL/album/createAlbum';

    final bodyy = {"title": albumTitle, "description": albumDescription};
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("resposed success Album created");
    } else {
      print("responsed failure Album creation");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to create album');
    }
  }

  static Future<List<SingleAlbumModel>> GetAlbum() async {
    var url = '$baseURL/user/albums/${CommonVars.userId}';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
    );

    final albumList = json.decode(response.body);
    List<SingleAlbumModel> albumModelList = [];

    if (response.statusCode == 200) {
      print("resposed success Album created");
      for (var i in albumList['albums']) {
        albumModelList.add(SingleAlbumModel.fromJson(i));
      }
      return albumModelList;
    } else {
      print("responsed failure Album creation");

      throw Exception('Failed to create album');
    }
  }

  static Future AddPhotoToAlbum(String photoId, String albumId) async {
    var url = '$baseURL/album/addPhoto';

    final bodyy = {"photoId": photoId, "albumId": albumId};
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("resposed success adding photo");
    } else {
      print("responsed failure adding photo");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to add photo');
    }
  }

  static Future<List<GetAlbumMediaModel>> GetAlbumMedia(String albumId) async {
    var urll = '$baseURL/album/$albumId';

    var response = await http.get(
      Uri.parse(urll),
      headers: {
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
    );
    if (response.statusCode == 200) {
      print("resposed success got album media");

      final photos = json.decode(response.body);

      List<GetAlbumMediaModel> listOfMedia = [];
      for (var i in photos['media']) {
        listOfMedia.add(GetAlbumMediaModel.fromJson(i));
      }

      return listOfMedia;
    } else {
      print("responsed failure to get to album media");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get album media');
    }
  }
}
