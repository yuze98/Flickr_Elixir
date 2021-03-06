import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CommonVars {
  static const String notifications = 'Notifications';
  static const String about = 'About';
  static const String help = 'Help';
  static const String signOut = 'Sign Out';
  static const String changePassword = 'Change Password';
  static const String public = 'Public';
  static const String private = 'Private';
  static bool isPublic;

  static String userName = "";
  static String userId = "";
  static bool hideAppBar = false;
  static int followings = -1;
  static int followers = -1;
  static String description = '';
  static String othersDescription = '';

  static String title = '';
  static String profilePhotoLink = "";
  static String coverPhotoLink = "";
  static String email = '';
  static String occupation = '';
  static bool loggedIn = false;
  static String tags = "";
  static String city = '';
  static String hometown = '';
  static String created = '';
  static int numberOfPhotos;
  static Map<String, dynamic> loginRes;
  static PickedFile photoFile;
  static bool sameUser = false;

  static bool camerarollbool = false;

  static String otherUserId = "";
  static String othersEmail = "";
  static String othersAccupation = "";
  static String othersCity = "";
  static String othersHometown = "";
  static String othersCreated = "";
  static int othersNumberOfPhotos = -1;
  static String otherUserName = "";
  static int othersFollowers = -1;
  static int othersFollowings = -1;
  static String othersCoverPhotoUrl = "";
  static String othersProfilePhotoUrl = "";

  static const List<String> menu = <String>[
    notifications,
    about,
    help,
    changePassword,
    signOut
  ];
  static bool isFollowing = false;
  static List<bool> hasPressed = [];

  static List<String> featuredPhotos = [];

  static List<String> otherFeaturedPhotos = [];

  static List<bool> favoriteUsersFollow = [];

  static const String album = 'Add to Album';

  static List<String> imageList = <String>[];
  static List<String> username = [];
  static List<String> titleCamera = [];
  static List<String> favCount = [];
  static List<String> commentNum = [];
  static List<bool> hasPressedCamera = [];
  static List<String> userID = [];
  static List<String> picID = [];
  static List<String> publicList = List();
  static List<String> privateList = List();

  static List<String> otherPublicList = List();
  static List<String> otherPrivateList = List();

  static const List<String> privacy = <String>[public, private];
  static const List<String> albums = <String>[album];

  static List<String> searchHistory = [];
  //for loading page
  static int count = 5;
}
