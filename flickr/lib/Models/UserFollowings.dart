/// This class is responsible to returns the user followings
/// @id : User Photo Id
/// @firstName : User First Name
/// @lastName : User last Name
/// @profilePhoto : User Profile photo link

class UserFollowings {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePhoto;

  UserFollowings({
    this.firstName,
    this.profilePhoto,
    this.lastName,
    this.id,
  });

  factory UserFollowings.fromJson(Map<String, dynamic> json) {
    return UserFollowings(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePhoto: json['profilePhotoUrl'],
    );
  }
}
