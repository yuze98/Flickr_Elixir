import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CommonVars {
  static const String notifications = 'Notifications';
  static const String about = 'About';
  static const String help = 'Help';
  static const String signOut = 'Sign Out';
  static const String changePassword = 'Change Password';
  static const String public = 'Public';
  static const String friends = 'Friends';
  static const String family = 'Family';
  static const String frdfam = 'Friends & Family';
  static const String private = 'Private';
  static String userName = "";
  static String userId = "";
  static bool hideAppBar = false;
  static int followings = -1;
  static int followers = -1;
  static String description = '';
  static String title = '';
  static String profilePhotoLink = '';
  static String coverPhotoLink = '';
  static String email = '';
  static String occupation = '';
  static String city = '';
  static String hometown = '';
  static String created = '';
  static int numberOfPhotos;
  static Map<String, dynamic> loginRes;
  static PickedFile photoFile;
  static const List<String> menu = <String>[
    notifications,
    about,
    help,
    changePassword,
    signOut
  ];

  static List<bool> hasPressed = [];

  static const String album = 'Add to Album';

  static List<String> imageList = <String>[
    'https://picsum.photos/800/600/?image=280',
    'https://picsum.photos/800/600/?image=281',
    'https://picsum.photos/800/600/?image=282',
    'https://picsum.photos/800/600/?image=283',
    'https://picsum.photos/800/600/?image=284'
  ];
  static List<String> publicList = List();
  static List<String> friendsList = List();
  static List<String> familyList = List();

  static const List<String> privacy = <String>[
    public,
    friends,
    family,
    frdfam,
    private
  ];
  static const List<String> albums = <String>[album];
}
