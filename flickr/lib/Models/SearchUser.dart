class SearchUser {
  final String id;
  final String profilePhotoUrl;
  final String firstName;
  final String lastName;
  final int numberOfFollowers;
  final int numberOfFollowings; // TODO check law fe number of photos instead
  final bool isFollowing;

  SearchUser({
    this.id,
    this.profilePhotoUrl,
    this.firstName,
    this.lastName,
    this.numberOfFollowers,
    this.numberOfFollowings,
    this.isFollowing,
  });

  factory SearchUser.fromJson(Map<String, dynamic> json) {
    return SearchUser(
      id: json['_id'],
      profilePhotoUrl: json['profilePhotoUrl'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      numberOfFollowers: json['numberOfFollowers'],
      numberOfFollowings: json['numberOfFollowings'],
      isFollowing: json['isFollowing'],
    );
  }
}
