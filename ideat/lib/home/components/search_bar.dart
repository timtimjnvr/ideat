import 'package:flutter/material.dart';
import 'package:ideat/screens/home/components/body.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:ideat/models/Product.dart';

//https://resocoder.com/2021/01/23/search-bar-in-flutter-logic-material-ui/#t-1611176327031

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBar> {
  static const historyLength = 5;
  final products_class = Products();
  late List<Product> products_list = products_class.products;
  late List<Product> searchResult = products_list;
  final List<String> _searchHistory = [];

  late List<String> filteredSearchHistory;
   String selectedTerm = "";

  List<String> filterSearchTerms({
  @required String? filter,
}) {
  if (filter != null && filter.isNotEmpty) {
    // Reversed because we want the last added items to appear first in the UI
    return _searchHistory.reversed
        .where((term) => term.startsWith(filter))
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
  // Changes in _searchHistory mean that we have to update the filteredSearchHistory
  filteredSearchHistory = filterSearchTerms(filter: null);
}
void deleteSearchTerm(String term) {
  _searchHistory.removeWhere((t) => t == term);
  filteredSearchHistory = filterSearchTerms(filter: null);
}
void putSearchTermFirst(String term) {
  deleteSearchTerm(term);
  addSearchTerm(term);
}

late FloatingSearchBarController controller;

@override
void initState() {
  super.initState();
  controller = FloatingSearchBarController();
  filteredSearchHistory = filterSearchTerms(filter: null);
}

@override
void dispose() {
  controller.dispose();
  super.dispose();
}

 List<Product> search(String term){
  List<Product> searchOutput = [];
  for (var p in products_list) {
   if (p.title.contains(RegExp(term, caseSensitive: false))) {
       searchOutput.add(p);  
   }
  }
  return searchOutput;
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: Body(searchResult),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm,
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search and find out...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
            searchResult = search(selectedTerm);
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
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
                },
              ),
            ),
          );
        },
      ),
    );
  }
}