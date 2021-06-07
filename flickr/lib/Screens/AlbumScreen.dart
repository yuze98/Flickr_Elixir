import 'package:flickr/Essentials/CommonVars.dart';
import 'package:flickr/Screens/RedirectAbPage.dart';
import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'AlbumSubScreen.dart';
import 'package:flickr/Models/GetAlbumMedia.dart';

class AlbumScreen extends StatefulWidget {
  AlbumScreen({
    this.receivedPicId,
    this.receivedUserId,
  });
  final receivedPicId;
  final receivedUserId;
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  List<Widget> listOfAlbumCards = [];
  Future<List<SingleAlbumModel>> albums;
  TextEditingController albumNameController = TextEditingController();
  String alertController;
  String picId;
  String userId;

  @override
  void initState() {
    super.initState();
    picId = widget.receivedPicId;
    userId = widget.receivedUserId;
    albums = FlickrRequestsAndResponses.getAlbum(userId);
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    listOfAlbumCards.clear();
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: FutureBuilder<List<SingleAlbumModel>>(
            future: albums,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SingleAlbumModel> data = snapshot.data;

                for (var i in data) {
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
        Visibility(
          visible: (picId == '' && userId == CommonVars.userId),
          child: Container(
            height: deviceSize.height * 0.05,
            child: RaisedButton.icon(
              color: Colors.blue,
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: Text(
                'Create Album',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Create album'),
                      content: TextField(
                        controller: albumNameController,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          hintText: 'Enter a name for your album',
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            // Send request to create album sending name and empty desciption
                            FlickrRequestsAndResponses.createAlbum(
                                albumNameController.text.toString().trim(), '');
                            Navigator.of(context).pop();
                            showAlertDialog(
                                context,
                                'Album {albumNameController.text.toString()} created',
                                alertController);
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        FlatButton(
                          color: Colors.white,
                          textColor: Colors.grey,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
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
        if (picId == '') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlbumSubScreen(
                receivedAlbumID: albumID,
                receivedAlbumName: albumName,
                receivedNumberOfPhotos: numberOfPhotos,
                receivedUserId: userId,
              ),
            ),
          );
        } else {
          FlickrRequestsAndResponses.addPhotoToAlbum(picId, albumID);
          Navigator.pop(context);
        }
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('images/albumsCoverPhoto.jpg'),
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
