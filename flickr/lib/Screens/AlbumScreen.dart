import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'AlbumSubScreen.dart';
import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Models/GetAlbumMedia.dart';

const String TEMPCOVERPHOTO =
    'https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  List<Widget> listOfAlbumCards = [];
  Future<List<SingleAlbumModel>> albums;
  Future<List<GetAlbumMediaModel>> listOfAlbumMedia;
  // List<Future<List<GetAlbumMediaModel>>> listOfListOfAlbumMedia;
  // String coverPhoto = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    albums = FlickrRequestsAndResponses.GetAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: RawMaterialButton(
            onPressed: () {
              // TODO e3mel popup yekteb el name w desc
              FlickrRequestsAndResponses.CreateAlbum(
                  'First created', 'Mabrook');
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            elevation: 0,
            constraints: BoxConstraints.tightFor(
              width: 20.0,
              height: 20.0,
            ),
            shape: CircleBorder(),
            fillColor: Color(0xFF0A4FA4),
          ),
        ),
        Expanded(
          flex: 5,
          child: FutureBuilder<List<SingleAlbumModel>>(
            future: albums,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SingleAlbumModel> data = snapshot.data;

                for (var i in data) {
                  // TODO Store data feen
                  // listOfListOfAlbumMedia[i] =
                  // FlickrRequestsAndResponses.GetAlbumMedia(i.albumId);
                  listOfAlbumCards.add(
                    AlbumCard(
                      i.albumId,
                      i.albumTitle,
                      i.numberOfPhotos,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: listOfAlbumCards.length,
                  itemBuilder: (context, index) => listOfAlbumCards[index],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }

  Widget AlbumCard(String albumID, String albumName, int numberOfPhotos) {
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
              receivedAlbumID: albumID,
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
                backgroundImage:
                    NetworkImage(TEMPCOVERPHOTO), //TODO get first photo
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
