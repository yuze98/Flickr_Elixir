import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CommonVars {
  static const String notifications = 'Notifications';
  static const String about = 'About';
  static const String help = 'Help';
  static const String signOut = 'Sign Out';
  static const String changePassword = 'Change Password';
  static bool hideAppBar = false;
  static int followings = -1;
  static int followers = -1;
  static final description = '';
  static final title = '';
  static Map<String, dynamic> loginRes;
  static PickedFile photoFile;
  static const List<String> menu = <String>[
    notifications,
    about,
    help,
    changePassword,
    signOut
  ];
}
