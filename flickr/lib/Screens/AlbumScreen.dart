import 'package:flutter/material.dart';
import 'AlbumSubScreen.dart';

const String TEMPCOVERPHOTO =
    'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  List<AlbumCard> listOfAlbums = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<dynamic> albums = [
      {
        "_id": "5349b4ddd2781d08c09890f4",
        "title": "First album",
        // "description": "Paris pics 2019",
        "creator": "2149b4ddd2781d08c09890a1",
        "numberOfPhotos": 1,
      },
      {
        "_id": "5349b4ddd2782d08c09890f4",
        "title": "Second album",
        // "description": "Paris pics 2019",
        "creator": "2149b4ddd2781d08c09890a2",
        "numberOfPhotos": 4,
      },
      {
        "_id": "5349b4ddd2783d08c09890f4",
        "title": "Third album",
        // "description": "Paris pics 2019",
        "creator": "2149b4ddd2781d08c09890a3",
        "numberOfPhotos": 4,
      }
    ];

    loadAlbumCard(albums);
  }

  void loadAlbumCard(List<dynamic> albums) {
    albums.forEach((element) {
      print(element["_id"]);
      print(element["title"]);
      print(element["numberOfPhotos"].toString());
      print(element["creator"]);
      print('Finito prints');
      listOfAlbums.add(AlbumCard(
        albumID: element["_id"],
        coverPhotoUrl: TEMPCOVERPHOTO,
        albumName: element["title"],
        numberOfPhotos: element["numberOfPhotos"],
      ));
    });
    print(listOfAlbums.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: new ListView.builder(
            itemCount: listOfAlbums.length,
            itemBuilder: (BuildContext context, int index) {
              return listOfAlbums[index];
            },
          ),
        ),
      ],
    );
  }
}

class AlbumCard extends StatelessWidget {
  AlbumCard(
      {this.albumID,
      this.coverPhotoUrl,
      @required this.albumName,
      this.numberOfPhotos,
      this.dateOfAlbumCreation,
      this.imagesUrl});
  final String albumID;
  final String coverPhotoUrl;
  final String albumName;
  final int numberOfPhotos;
  final String dateOfAlbumCreation;
  final List<String> imagesUrl;

  @override
  Widget build(BuildContext context) {
    String numberOfPhotosString = numberOfPhotos > 1
        ? numberOfPhotos.toString() + ' photos'
        : numberOfPhotos.toString() + ' photo';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => MyHomePage(),
            builder: (context) => AlbumSubScreen(
              receivedAlbumName: albumName,
              receivedNumberOfPhotos: numberOfPhotos,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(coverPhotoUrl),
              ),
              title: Text(albumName),
              isThreeLine: false, // TODO convert it to true if you need date
              subtitle: Text(numberOfPhotosString),
            ),
          ],
        ),
      ),
    );
  }
}
