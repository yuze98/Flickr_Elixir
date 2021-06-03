class SingleAlbumModel {
  final String albumId;
  final String albumTitle;
  final int numberOfPhotos;

  SingleAlbumModel({
    this.albumId,
    this.albumTitle,
    this.numberOfPhotos,
  });

  factory SingleAlbumModel.fromJson(Map<String, dynamic> json) {
    return SingleAlbumModel(
      albumId: json['_id'],
      albumTitle: json['title'],
      numberOfPhotos: json['numberOfPhotos'],
    );
  }
}

class GetAlbumMediaModel {
  final String picId;
  final String url;
  final String title;
  final String firstName;
  final String lastName;
  final int favoriteCount;
  final int commentsNum;

  GetAlbumMediaModel({
    this.picId,
    this.url,
    this.firstName,
    this.title,
    this.lastName,
    this.favoriteCount,
    this.commentsNum,
  });

  factory GetAlbumMediaModel.fromJson(Map<String, dynamic> json) {
    return GetAlbumMediaModel(
      picId: json['_id'],
      url: json['url'],
      firstName: json['creator']['firstName'],
      title: json['title'],
      lastName: json['creator']['lastName'],
      favoriteCount: json['favouriteCount'],
      commentsNum: json['commentsNum'],
    );
  }
}
