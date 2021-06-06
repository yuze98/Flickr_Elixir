class AboutPhotoModel {
  final List<String> tags;
  final String title;
  final bool isPublic;
  final String lastName;
  final String firstName;
  final String albumPic;

  AboutPhotoModel({
    this.albumPic,
    this.tags,
    this.title,
    this.lastName,
    this.firstName,
    this.isPublic,
  });

  factory AboutPhotoModel.fromJson(Map<String, dynamic> json) {
    List<String> temp = [];

    for (var i in json['tags']) {
      temp.add(i['name']);
    }

    return AboutPhotoModel(
      tags: temp,
      title: json['title'],
      isPublic: json['isPublic'],
      firstName: json['creator']['firstName'],
      lastName: json['creator']['lastName'],
      albumPic: json['url'],
    );
  }
}
