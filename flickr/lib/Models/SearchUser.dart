/// This class is responsible to returns the user names who matches the word of search
/// @id : User Photo Id
/// @isFollowing : Following this user or not
/// @firstName : User First Name
/// @lastName : User last Name
/// @favoriteCount : Number of users who favourite the photo
/// @numberOfPhotos : Number of User Photos
/// @profilePhotoUrl : User Profile photo link
/// @numberOfFollowers : Number of User's followers
class SearchUser {
  final String id;
  final String profilePhotoUrl;
  final String firstName;
  final String lastName;
  final int numberOfFollowers;
  final int numberOfPhotos;
  final bool isFollowing;

  SearchUser({
    this.id,
    this.profilePhotoUrl,
    this.firstName,
    this.lastName,
    this.numberOfFollowers,
    this.numberOfPhotos,
    this.isFollowing,
  });

  factory SearchUser.fromJson(Map<String, dynamic> json) {
    return SearchUser(
      id: json['_id'],
      profilePhotoUrl: json['profilePhotoUrl'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      numberOfFollowers: json['numberOfFollowers'],
      numberOfPhotos: json['numberOfPhotos'],
      isFollowing: json['isFollowing'],
    );
  }
}
