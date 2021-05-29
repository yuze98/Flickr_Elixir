import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Essentials/CommonVars.dart';

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

  static Future<int> getFollowings() async {
    const String baseURL =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';

    var url = '$baseURL/user/followings/:5349b4ddd2781d08c09890f4';

    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followings = decoded['Following'];
    CommonVars.followings = followings.length;
    print("size is ${followings.length}");
    return followings.length;
  }

  static Future<int> getFollowers() async {
    const String baseURL =
        'https://a1a0f024-6781-4afc-99de-c0f6fbb5d73d.mock.pstmn.io/';

    var url = '$baseURL/user/followers/:5349b4ddd2781d08c09890f4';
    var response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<dynamic> followers = decoded['followers'];
    CommonVars.followers = followers.length;
    print("size is ${followers.length}");
    return followers.length;
  }
}
