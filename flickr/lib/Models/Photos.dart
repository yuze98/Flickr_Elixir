class Photos {
  final String url;
  final String title;
  final String firstName;
  final String lastName;
  final int favoriteCount;
  final int commentsNum;

  Photos({
    this.url,
    this.firstName,
    this.title,
    this.lastName,
    this.favoriteCount,
    this.commentsNum,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      url: json['url'],
      firstName: json['creator']['firstName'],
      title: json['title'],
      lastName: json['creator']['lastName'],
      favoriteCount: json['favoriteCount'],
      commentsNum: json['commentsNum'],
    );
  }
}