///Fetches info about Photo from API
/// @userID : ID of the user
/// @pictureID : ID of the picture
/// @url : URL of the Images
/// @title : Title of the photo
/// @firstName : First name of user's photo
/// @lastName : Last name of user's photo
/// @favoriteCount : Number of people who liked
/// @commentsNum : Number of people who commented
/// @isPublic :Privacy status of photo
/// @profilePhotoUrl : URL of the profilePhoto

class CameraRollModel {
  final String userID;
  final String pictureID;
  final String url;
  final String title;
  final String firstName;
  final String lastName;
  final int favoriteCount;
  final int commentsNum;
  final bool isPublic;
  final String profilePhotoUrl;

  CameraRollModel({
    this.userID,
    this.pictureID,
    this.url,
    this.firstName,
    this.title,
    this.lastName,
    this.favoriteCount,
    this.commentsNum,
    this.profilePhotoUrl,
    this.isPublic,
  });

  factory CameraRollModel.fromJson(Map<String, dynamic> json) {
    print(json['favouriteCount']);
    return CameraRollModel(
        userID: json['creator']['_id'],
        pictureID: json['_id'],
        url: json['url'],
        profilePhotoUrl: json['creator']['profilePhotoUrl'],
        firstName: json['creator']['firstName'],
        title: json['title'],
        lastName: json['creator']['lastName'],
        favoriteCount: json['favouriteCount'],
        commentsNum: json['commentsNum'],
        isPublic: json['isPublic']);
  }
}
