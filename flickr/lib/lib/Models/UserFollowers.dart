class UserFollowers {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePhoto;

  UserFollowers({
    this.firstName,
    this.profilePhoto,
    this.lastName,
    this.id,
  });

  factory UserFollowers.fromJson(Map<String, dynamic> json) {
    return UserFollowers(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePhoto: json['profilePhotoUrl'],
    );
  }
}
