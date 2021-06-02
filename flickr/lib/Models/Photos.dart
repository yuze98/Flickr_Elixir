class Photos {
  final String id;
  final String url;
  final String title;
  final String firstName;
  final String lastName;
  final int favoriteCount;
  final int commentsNum;
  final String profilePhotoUrl;

  Photos({
    this.id,
    this.url,
    this.firstName,
    this.title,
    this.lastName,
    this.favoriteCount,
    this.commentsNum,
    this.profilePhotoUrl,
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
    );
  }
}
