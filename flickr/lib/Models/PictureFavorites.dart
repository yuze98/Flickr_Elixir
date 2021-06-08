/// This class is responsible to save the data of users who favorite a certain photo
/// @id : User Photo Id
/// @isFollowing : Following this user or not
/// @firstName : User First Name
/// @lastName : User last Name
/// @favoriteCount : Number of users who favourite the photo
/// @photosCount : Number of User Photos
/// @profilePhoto : User Profile photo link
/// @followersNum : Number of User's followers
class PictureFavorites {
  final String id;
  final bool isFollowing;
  final String firstName;
  final String lastName;
  final int favoriteCount;
  final int photosCount;
  final String profilePhoto;
  final int followersNum;

  PictureFavorites(
      {this.isFollowing,
      this.firstName,
      this.profilePhoto,
      this.lastName,
      this.favoriteCount,
      this.photosCount,
      this.id,
      this.followersNum});

  factory PictureFavorites.fromJson(Map<String, dynamic> json) {
    return PictureFavorites(
      id: json['_id'],
      firstName: json['firstName'],
      followersNum: json['numberOfFollowers'],
      lastName: json['lastName'],
      profilePhoto: json['profilePhotoUrl'],
      photosCount: json['numberOfPhotos'],
      isFollowing: json['isFollowing'],
    );
  }
}
