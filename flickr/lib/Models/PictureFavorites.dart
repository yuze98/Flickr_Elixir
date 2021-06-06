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
