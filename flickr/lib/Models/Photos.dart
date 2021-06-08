///Fetches info about Photo from API
/// @id : ID of the photo
/// @url : URL of the Image
/// @title : Title of the photo
/// @firstName : First name of user's photo
/// @lastName : Last name of user's photo
/// @favoriteCount : Number of people who liked
/// @commentsNum : Number of people who commented
/// @userId : ID of the user
/// @profilePhotoUrl : URL of the profilePhoto

class Photos {
  final String id;
  final String url;
  final String title;
  final String firstName;
  final String lastName;
  final int favoriteCount;
  final int commentsNum;
  final String profilePhotoUrl;
  final String userId;

  Photos({
    this.id,
    this.url,
    this.firstName,
    this.title,
    this.lastName,
    this.favoriteCount,
    this.commentsNum,
    this.profilePhotoUrl,
    this.userId,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    print(json['favouriteCount']);
    return Photos(
      id: json['_id'],
      url: json['url'],
      profilePhotoUrl: json['creator']['profilePhotoUrl'],
      firstName: json['creator']['firstName'],
      title: json['title'],
      lastName: json['creator']['lastName'],
      favoriteCount: json['favouriteCount'],
      commentsNum: json['commentsNum'],
      userId: json['creator']['_id'],
    );
  }
}
