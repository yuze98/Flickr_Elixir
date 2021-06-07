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
import 'package:flickr/Models/SearchUser.dart';
import 'package:flickr/Models/PhotoStreamModel.dart';

class FlickrRequestsAndResponses {
  static final String _baseURL = 'https://api.qasaqees.tech';

  static Future<http.Response> logIn(final email, final password) async {
    const String baseURL = 'https://api.qasaqees.tech/register/logIn';

    var jso = {
      "email": "${email.text.toString().trim()}",
      "password": "${password.text}",
    };

    var url = '$baseURL/register/logIn';
    var response = await http.post(
      Uri.parse(baseURL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(jso),
    );

    CommonVars.loginRes = json.decode(response.body);

    return response;
  }

  static Future<http.Response> changePassword(
      String newPasswordController, String oldPasswordController) async {
    var url = "https://api.qasaqees.tech/register/changePassword";

    var jso = {
      'newPass': '$newPasswordController',
      'oldPass': '$oldPasswordController'
    };

    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
      },
      body: jsonEncode(jso),
    );

    return response;
  }

  static Future<int> getUserID() async {
    var url = '$_baseURL/user/Loginauser/:5349b4ddd2781d08c09890f4';

    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followings = decoded['Following'];
    CommonVars.followings = followings.length;

    return followings.length;
  }

  static Future<int> getFollowings(String id) async {
    var url = '$_baseURL/user/followings/:$id';

    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followings = decoded['Following'];
    CommonVars.followings = followings.length;
    return followings.length;
  }

  static Future<int> getFollowers(String id) async {
    var url = '$_baseURL/user/followers/:$id';
    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followers = decoded['followers'];
    CommonVars.followers = followers.length;

    return followers.length;
  }

  static Future<int> signOutRequest() async {
    var urll = 'https://api.qasaqees.tech';
    var url = '$urll/register/logOut';

    var response = await http.post(Uri.parse(url), headers: {
      "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
    });
    print(response.body);
    return response.statusCode;
  }

  static Future<int> signUpRequests(
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

    return response.statusCode;
  }

  static Future<int> signUpFB(final FacebookLogin facebookSignIn) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    int statusCode = 0;

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;

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

        statusCode = response.statusCode;

        break;
      case FacebookLoginStatus.cancelledByUser:
        await facebookSignIn.logOut();
        break;
      case FacebookLoginStatus.error:
        break;
    }
    return statusCode;
  }

  static Future<http.Response> logInFB(
      final FacebookLogin facebookSignIn) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    int statusCode = 0;
    var response;
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;

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

        statusCode = response.statusCode;

        break;
      case FacebookLoginStatus.cancelledByUser:
        await facebookSignIn.logOut();
        break;
      case FacebookLoginStatus.error:
        break;
    }
    return response;
  }

  static Future<List<Photos>> getExplore() async {
    var urll = '$_baseURL/photo/explore';

    var response = await http.get(
      Uri.parse(urll),
    );
    if (response.statusCode == 200) {
      final photos = json.decode(response.body);

      List<Photos> vo = [];
      for (var i in photos['photos']) {
        vo.add(Photos.fromJson(i));
      }

      return vo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future addToFavorite(String photoIDFaved) async {
    var url = '$_baseURL/photo/addToFavorites';

    final bodyy = {'photoId': '$photoIDFaved'};
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

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

  static Future<List<PictureFavorites>> getFavoriteUsers(String picId) async {
    var urll = '$_baseURL/photo/whoFavorited/$picId';

    var response = await http.get(Uri.parse(urll), headers: {
      'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
    });

    if (response.statusCode == 200) {
      final favorites = json.decode(response.body);

      List<PictureFavorites> vo = [];
      for (var i in favorites['user']) {
        vo.add(PictureFavorites.fromJson(i));
      }

      return vo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load get favorite');
    }
  }

  static Future addComment(String picId, String userComment) async {
    var urll = '$_baseURL/photo/$picId/comment';

    var bodyy = {'comment': '$userComment'};
    var response = await http.post(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
        },
        body: jsonEncode(bodyy));

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future getAbout() async {
    var url = 'https://api.qasaqees.tech/user/about/${CommonVars.userId}';

    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final about = json.decode(response.body);

      for (int i in about['user']['showCase']['photos']) {
        CommonVars.featuredPhotos
            .add(about['user']['showCase']['photos'][i]['url']);
      }

      CommonVars.description = about['user']['description'];
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
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<PictureComments>> GetComments(String picId) async {
    var urll = '$_baseURL/photo/getComments';
    final bodyy = {"photoId": '$picId'};

    var response = await http.post(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyy));

    if (response.statusCode == 200) {
      final commentList = json.decode(response.body);

      List<PictureComments> vo = [];
      for (var i in commentList['comments']) {
        vo.add(PictureComments.fromJson(i));
      }
      return vo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Comments');
    }
  }

  static Future<AboutPhotoModel> getAboutPhoto(String picId) async {
    var urll = '$_baseURL/photo/getDetails/';

    final bodyy = {'photoId': '$picId'};
    var response = await http.post(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
        },
        body: jsonEncode(bodyy));

    if (response.statusCode == 200) {
      final aboutPic = json.decode(response.body);

      AboutPhotoModel vo = AboutPhotoModel.fromJson(aboutPic);

      print(vo.title);
      return vo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load info of the pic');
    }
  }

  static Future<List<CameraRollModel>> getCameraRoll() async {
    var url = '$_baseURL/user/cameraRoll';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final cameralist = json.decode(response.body);

      List<CameraRollModel> vo = [];
      for (var i in cameralist['cameraRoll']) {
        vo.add(CameraRollModel.fromJson(i));
      }

      return vo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load camera roll');
    }
  }

  /*******************************************************************************/

  static Future<String> uploadImage() async {
    const String baseURL = 'https://api.qasaqees.tech/photo/upload';

    var request = http.MultipartRequest('POST', Uri.parse(baseURL));

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
    var response = await http.Response.fromStream(res);

    var body = jsonDecode(response.body);
    return body["_id"];
  }

  static changeCoverPhoto(String id) async {
    const String baseURL = 'https://api.qasaqees.tech';
    var urll = 'https://api.qasaqees.tech/user/editCoverPhoto';

    var body = {"photoId": id};
    var response = await http.patch(Uri.parse(urll),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
        },
        body: jsonEncode(body));
  }

  static profileCoverPhoto(String id) async {
    const String baseURL = 'https://api.qasaqees.tech';
    var urll = 'https://api.qasaqees.tech/user/editProfilePhoto';

    var body = {"photoId": id};
    var response = await http.patch(Uri.parse(urll),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
        },
        body: jsonEncode(body));
  }

  static Future followUser(String userTobeFollowed) async {
    var urll = '$_baseURL/user/followUser';

    var bodyy = {'userId': userTobeFollowed};

    var response = await http.post(Uri.parse(urll),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
        },
        body: jsonEncode(bodyy));

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load follow');
    }
  }

  static Future addTags(String picId, String tag) async {
    var urll = '$_baseURL/photo/addTags/$picId';

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
    } else {
      throw Exception('Failed to add tag');
    }
  }

  static Future editAboutInfo(
      String occupation, String hometown, String city) async {
    var urll = '$_baseURL/user/editInfo';

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
    } else {
      throw Exception('Failed to load edit about info');
    }
  }

  static Future forgetPass(String email) async {
    var url = '$_baseURL/register/forgetPassword';
    var jso = {'email': email};

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jso),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to forgetpass');
    }

    return response;
  }

  static Future<String> showOtherUserProfile(String id) async {
    var url = 'https://api.qasaqees.tech/user/about/$id';

    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
    });

    if (response.statusCode == 200) {
      final about = json.decode(response.body);
      CommonVars.othersDescription = about['user']['description'];

      for (int i in about['user']['showCase']['photos']) {
        CommonVars.otherFeaturedPhotos
            .add(about['user']['showCase']['photos'][i]['url']);
      }
      CommonVars.isFollowing = about['user']['isFollowing'];

      CommonVars.otherUserId = id;
      CommonVars.othersDescription = about['user']['description'];
      CommonVars.otherUserName =
          about['user']['firstName'] + " " + about['user']['lastName'];
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
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    print(response.body);
  }

  static Future<List<UserFollowings>> getUserFollowings(String userid) async {
    var urll = '$_baseURL/user/followings/$userid';

    var response = await http.get(Uri.parse(urll), headers: {
      'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
    });

    if (response.statusCode == 200) {
      final favorites = json.decode(response.body);

      List<UserFollowings> vo = [];
      for (var i in favorites['following']) {
        vo.add(UserFollowings.fromJson(i));
      }

      return vo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load get favorite');
    }
  }

  static Future<List<UserFollowers>> getUserFollowers(String userid) async {
    var urll = '$_baseURL/user/followers/$userid';

    var response = await http.get(Uri.parse(urll), headers: {
      'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
    });

    if (response.statusCode == 200) {
      final favorites = json.decode(response.body);

      List<UserFollowers> vo = [];
      for (var i in favorites['followers']) {
        vo.add(UserFollowers.fromJson(i));
      }

      return vo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load get favorite');
    }
  }

  static Future unFollowUser(String userTobeUnFollowed) async {
    var urll = '$_baseURL/user/unfollowUser';

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
    } else {
      throw Exception('Failed to load unfollow');
    }
  }

  static Future deletePicture(String picId) async {
    var urll = '$_baseURL/photo/delete/$picId';

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
    } else {
      throw Exception('Failed to load Delete');
    }
  }

  static Future createAlbum(String albumTitle, String albumDescription) async {
    var url = '$_baseURL/album/createAlbum';

    final bodyy = {"title": albumTitle, "description": albumDescription};
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to create album');
    }
  }

  static Future<List<SingleAlbumModel>> getAlbum() async {
    var url = '$_baseURL/user/albums/${CommonVars.userId}';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
    );

    final albumList = json.decode(response.body);

    List<SingleAlbumModel> albumModelList = [];

    if (response.statusCode == 200) {
      for (var i in albumList['albums']) {
        albumModelList.add(SingleAlbumModel.fromJson(i));
      }
      return albumModelList;
    } else {
      throw Exception('Failed to create album');
    }
  }

  static Future addPhotoToAlbum(String photoId, String albumId) async {
    var url = '$_baseURL/album/addPhoto';

    final bodyy = {"photoId": photoId, "albumId": albumId};
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to add photo');
    }
  }

  static Future<List<GetAlbumMediaModel>> getAlbumMedia(String albumId) async {
    var urll = '$_baseURL/album/$albumId';

    var response = await http.get(
      Uri.parse(urll),
      headers: {
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
    );

    if (response.statusCode == 200) {
      final photos = json.decode(response.body);

      List<GetAlbumMediaModel> listOfMedia = [];
      for (var i in photos['media']) {
        listOfMedia.add(GetAlbumMediaModel.fromJson(i));
      }

      return listOfMedia;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get album media');
    }
  }

  static Future DeleteAlbum(String albumId) async {
    var urll = '$_baseURL/album/deleteAlbum/$albumId';

    var response = await http.delete(
      Uri.parse(urll),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load Delete Album');
    }
  }

  static Future renameAlbum(String albumId, String newAlbumTitle) async {
    var urll = '$_baseURL/album/$albumId';

    var bodyy = {
      "title": newAlbumTitle,
    };

    var response = await http.patch(
      Uri.parse(urll),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    if (response.statusCode == 200) {
    } else if (response.statusCode == 404) {
      throw Exception('Album not found');
    } else {
      throw Exception('Invalid token');
    }
  }

  static Future<List<SearchUser>> searchOnUser(String searchKeyword) async {
    var urll = '$_baseURL/user/search/$searchKeyword';

    var response = await http.get(
      Uri.parse(urll),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    final usersList = json.decode(response.body);
    List<SearchUser> searchUserModelList = [];

    if (response.statusCode == 200) {
      for (var i in usersList['users']) {
        searchUserModelList.add(SearchUser.fromJson(i));
      }

      return searchUserModelList;
    } else {
      throw Exception('Failed to find user');
    }
  }

  static Future removePicFromAlbum(String picId, String albumId) async {
    var urll = '$_baseURL/album/deletePhoto';

    var bodyy = {
      "photoId": picId,
      "albumId": albumId,
    };

    var response = await http.delete(
      Uri.parse(urll),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
      body: jsonEncode(bodyy),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to remove image from album');
    }
  }

  static Future<http.Response> resetPassword(String emailController,
      String newPasswordController, String codeController) async {
    var url = "https://api.qasaqees.tech/register/resetPassword";

    var jso = {
      "email": emailController,
      "newPass": newPasswordController,
      "code": codeController
    };

    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(jso),
    );

    return response;
  }

  static Future allowCommenting(String photoId, bool isPublic) async {
    var url = "https://api.qasaqees.tech/photo/allowCommenting";

    var jso = {"photoId": photoId, "isPublic": isPublic};
    print("Before Res");

    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
      },
      body: jsonEncode(jso),
    );
    print(json.decode(response.body));
  }

  static Future editPhoto(String photoId, bool isPublic, String title) async {
    var url = "https://api.qasaqees.tech/photo/$photoId";

    var jso = {
      "isPublic": isPublic,
      "title": title,
      "description": '',
      "tags": [],
      "allowCommenting": true,
    };

    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
      },
      body: jsonEncode(jso),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to edit photo');
    }
  }

  static Future<List<PhotoStreamModel>> getPhotoStream(String id) async {
    var url = '$_baseURL/user/photostream/$id';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${CommonVars.loginRes['accessToken']}'
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final cameralist = json.decode(response.body);

      List<PhotoStreamModel> vo = [];
      for (var i in cameralist['photos']) {
        vo.add(PhotoStreamModel.fromJson(i));
      }

      return vo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load camera roll');
    }
  }
}
