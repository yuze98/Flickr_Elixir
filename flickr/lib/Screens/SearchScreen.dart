import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const historyLength = 3;
  List<String> _searchHistory = [
    'Fathy',
    'Abdallah',
    'Youssef',
  ];

  List<String> filteredSearchHistory;

  String selectedTerm;

  List<String> filteredSearchTerms({@required String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.toLowerCase().startsWith(filter.toLowerCase()))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((element) => element == term);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
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
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  const SearchResultsListView({@required this.searchTerm});
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.search,
            size: 64,
          ),
          Text(
            'Flickr Search',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      );
    }

    return ListView(
      padding:
          EdgeInsets.only(top: 48.0 + MediaQuery.of(context).viewPadding.top),
      children: List.generate(
        30,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
          onTap: () {
            Navigator.pushNamed(context, 'SearchPage');
          },
        ),
      ),
    );
  }
}
