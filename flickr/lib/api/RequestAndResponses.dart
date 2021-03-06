import 'dart:convert';
import 'package:flickr/Models/CameralRollModel.dart';
import 'package:flickr/Screens/CameraRoll.dart';
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

/// This class is responsible for sending requests and receiving responses
/// @_baseURL: is the url of our server

class FlickrRequestsAndResponses {
  static final String _baseURL = 'https://api.qasaqees.tech';

  /// LogIn function is responsible for sending @email and @password to allow to the user to logIn in his account and view [LoginScreen]
  /// @email: User Email
  /// @password: User Password
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

  /// changePassword function is responsible for allowing the user to change his account Password through [ChangePassword]
  /// @newPasswordController: User New Password
  /// @oldPasswordController: User Old Password
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

  /// getFollowings function is responsible for getting the number of Followings for a certain user
  /// @id: Required User Id
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

  /// getFollowers function is responsible for getting the number of followers for a certain user
  /// @id: Required User Id
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

  /// signOutRequest function is responsible for inform the server that a certain user logout and redirect the user to [GetStarted]
  static Future<int> signOutRequest() async {
    var urll = 'https://api.qasaqees.tech';
    var url = '$urll/register/logOut';

    var response = await http.post(Uri.parse(url), headers: {
      "Authorization": "Bearer ${CommonVars.loginRes["accessToken"]}"
    });
    print(response.body);
    return response.statusCode;
  }

  /// signUpRequests function is responsible for sending User Date to the server to allow the user to Sign up with his email [Signup]
  /// @passwordController: User Password
  /// @emailController: User Email
  /// @firstNameController: User First Name
  /// @secondNameController: User Second Name
  /// @ageController: User Age
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

  /// signUpFB function is responsible for sending Sending requesto to FB API to get the token of the user to signup [Signup]
  /// @facebookSignIn: FB Token
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

  /// logInFB function is responsible for sending a login request to FB API to allow the user to login in our APP [LoginScreen]
  /// @facebookSignIn: FB Access Token

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

  /// getExplore function is responsible for fetching the photos from the server and put them in [ImageList]
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

  /// addToFavorite function is responsible to allow the user to favourite a photo using get the photo id
  /// @photoIDFaved: Photo's ID

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

  /// getFavoriteUsers function is responsible to get the user who Favorite a certain photo
  /// @picId: Photo's ID
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

  /// addComment function is responsible to add comments to a certain photo of a certain user
  /// @picId: Photo's ID
  /// @userComment: Photo's ID
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

  /// getAbout function is responsible to return the info about a certain user and display it in [AboutState] view
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

  /// GetComments function is responsible to return the photo comments and their data
  /// @picId: Photo Id

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

  /// getAboutPhoto function is responsible to return the photo info [AboutPhoto] view
  /// @picId: Photo Id
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

  /// getCameraRoll function is responsible to return the photos of user photostream about a certain user and display it in [CameraRoll] view

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
    //??  return res.reasonPhrase;
    var response = await http.Response.fromStream(res);

    var body = jsonDecode(response.body);
    return body["_id"];
  }

  /// This API Function takes the user's @id and changes his Cover Photo
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

  /// This API Function takes the user's @id and changes his Profile Photo
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
    print(response.body);
  }

  /// This API Function takes the user's @id and Sends a request to follow him
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

  /// This API Function takes the user's picture ID and the Tag @picId @tag
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

  /// This API Function takes the changes needed to edit his info
  /// @occupation: takes the occupation of the user
  /// @hometown: takes the hometown of the user
  /// @city: takes the city the user entered
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

  /// This API Function takes the user email and the server send him a recovery password to his email
  /// @email: takes the user's email
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

  /// This API Function takes the other user's id and gets all his info for his profile page
  /// @id: takes the other user's id
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

  /// This API Function takes the user's id and returns a list containing all the other users he follows
  /// @userid: the user id
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

  /// This API Function takes the user's id and returns a list containing all his followers
  /// @userid: the user id
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

  /// This API Function takes the user's id  who is going to be unfollowed by the current user
  /// @userTobeUnFollowed: the id of the user to be unfollowed by the current user
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

  /// This API Function takes the pictures id which will be deleted
  /// @picId: the picture id which will be deleted
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

  /// This API Function creates a new album by taking the follwoing parameters
  /// @albumTitle: takes the title of the album to be created
  /// @albumDescription: takes the description of the album to be created
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

  /// This API Function takes the user id and returns a list containing all his albums
  /// @userid: the user's id to capture his albums
  static Future<List<SingleAlbumModel>> getAlbum(String userId) async {
    var url = '$_baseURL/user/albums/$userId';

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

  /// This API Function adds a photo to a certain album
  /// @photoId: takes the id of the photo to be added
  /// @albumId: takes the id of the album to add the the photo in
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

  /// This API Function returns a list which will have all the picture in an album
  /// @albumId: the id of the album which contains all the pictures
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

  /// This API Function deleted a certain album
  /// @albumId: the id of the album to be deleted
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

  /// This API Function Renames the album and changes its title
  /// @albumId: the id of the album to be renamed
  /// @newAlbumTitle : the new title of the album
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

  /// This API Function searches for a specific user and returns the list of all users with similar names
  /// @searchKeyword: takes the name of a user to search for
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

  /// This API Function removes a pictures from the album
  /// @picId: takes the id of the picture to be removed from the album
  /// @albumId: takes the id of the album
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

  /// This API Function resets the password and sends a new password to the user's email returns the response of the server
  /// @emailController: the email of the user
  /// @newPasswordController: takes the user's the new password
  /// @codeController: the verification code which was sent to the user's
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

  /// This API Function allows other users to comment on the picture
  /// @photoId: the id of the picture
  /// isPublic: a boolean to set the picture to public or private
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

  /// This API Function edits the photo and changes its title and its publicity
  /// @photoId: the id of the photo to be edited
  /// isPublic: a boolean to set the picture to public or private
  /// title: the new changed title of the picture
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

  /// This API Function returns a list containing all the photos in the [CameraRoll]
  /// @id: the id of the user for his pictures
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
