class PictureComments {
  final String profilePhotoUrl;
  final String firstName;
  final String lastName;
  final String commment;

  PictureComments(
      {this.profilePhotoUrl, this.firstName, this.lastName, this.commment});

  factory PictureComments.fromJson(Map<String, dynamic> json) {
    return PictureComments(
      profilePhotoUrl: json['user']['profilePhotoUrl'],
      firstName: json['user']['firstName'],
      lastName: json['user']['lastName'],
      commment: json['text'],
    );
  }
}
