import 'package:flickr/api/RequestAndResponses.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flickr/Models/SearchUser.dart';
import 'OthersSubProfile.dart';
import 'package:flickr/Essentials/CommonVars.dart';

// List<String> addedTextToFollowing = [];
// List<String> addedTextToFollowers = [];

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const historyLength = 3;
  // Move search history to common vars

  List<String> filteredSearchHistory;

  String selectedTerm;

  List<String> filteredSearchTerms({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return CommonVars.searchHistory.reversed
          .where((term) => term.toLowerCase().startsWith(filter.toLowerCase()))
          .toList();
    } else {
      return CommonVars.searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (CommonVars.searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    CommonVars.searchHistory.add(term);
    if (CommonVars.searchHistory.length > historyLength) {
      CommonVars.searchHistory
          .removeRange(0, CommonVars.searchHistory.length - historyLength);
    }
    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    CommonVars.searchHistory.removeWhere((element) => element == term);
    filteredSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future refreshScreen() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshScreen,
      child: Scaffold(
        body: FloatingSearchBar(
          controller: controller,
          body: FloatingSearchBarScrollNotifier(
            child: SearchResultsListView(
              searchTerm: selectedTerm,
            ),
          ),
          transition: CircularFloatingSearchBarTransition(),
          physics: BouncingScrollPhysics(),
          title: Text(
            selectedTerm ?? 'Search Flickr',
            style: Theme.of(context).textTheme.headline6,
          ),
          hint: 'Search Flickr',
          actions: [
            FloatingSearchBarAction.searchToClear(),
          ],
          onQueryChanged: (query) {
            setState(() {
              filteredSearchHistory = filteredSearchTerms(filter: query);
            });
          },
          onSubmitted: (query) {
            setState(() {
              addSearchTerm(query);
              selectedTerm = query;
            });
            controller.close();
          },
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: Builder(builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                });
                                controller.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  SearchResultsListView({@required this.searchTerm});
  final String searchTerm;
  List<Widget> listOfSearchedUsers = [];
  Future<List<SearchUser>> userFoundList;

  @override
  Widget build(BuildContext context) {
    Widget UserSearchedCard(
      String userId,
      String userPhotoUrl,
      String userFirstName,
      String userLastName,
      int userNumberOfFollowers,
      int userNumberOfFollowing,
      bool isFollowingUser,
    ) {
      return GestureDetector(
        onTap: () async {
          CommonVars.otherUserId = userId;
          String body =
              await FlickrRequestsAndResponses.showOtherUserProfile(userId);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtherProfile(),
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
                      // get user profile
                      NetworkImage(userPhotoUrl),
                ),
                // get user name
                title: Text(
                  userFirstName + ' ' + userLastName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isThreeLine: false,
                // add number of photos/following and number of followers
                subtitle: Text(
                  userNumberOfFollowing.toString() +
                      ' following(s)' +
                      ' - ' +
                      userNumberOfFollowers.toString() +
                      ' follower(s)',
                  style: TextStyle(
                    // fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
                // TODO trailing button of following or follow
              ),
            ],
          ),
        ),
      );
    }

    var deviceSize = MediaQuery.of(context).size;
    if (searchTerm == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.search,
            size: 64,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: deviceSize.height * 0.03 +
                    MediaQuery.of(context).viewPadding.top),
            child: Text(
              'Flickr Search',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      );
    } else {
      userFoundList =
          FlickrRequestsAndResponses.searchOnUser(searchTerm.toLowerCase());

      return FutureBuilder<List<SearchUser>>(
        future: userFoundList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SearchUser> data = snapshot.data;
            // TODO delete all comments in this function
            // int index = 0;
            for (var i in data) {
              // addedTextToFollowing[index] =
              //     (i.numberOfFollowings == 1) ? ' following' : ' followings';
              // addedTextToFollowers[index] =
              //     (i.numberOfFollowings == 1) ? ' follower' : ' followers';
              listOfSearchedUsers.add(
                UserSearchedCard(
                  i.id,
                  i.profilePhotoUrl,
                  i.firstName,
                  i.lastName,
                  i.numberOfFollowers,
                  i.numberOfFollowings,
                  i.isFollowing,
                ),
              );
              // index++;
            }
            return ListView.builder(
              padding: EdgeInsets.only(
                top: deviceSize.height * 0.08 +
                    MediaQuery.of(context).viewPadding.top,
              ),
              itemCount: listOfSearchedUsers.length,
              itemBuilder: (context, index) => listOfSearchedUsers[index],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default show a loading spinner.
          return CircularProgressIndicator();
        },
      );
    }
  }
}
