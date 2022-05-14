import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends SearchDelegate {
  final List CountryList;
  var height = Get.height;
  var width = Get.width;

  Search(this.CountryList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: height * .25,
        width: width * .25,
        color: Colors.grey.shade300,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? CountryList
        : CountryList.where((element) => element['country']
            .toLowerCase()
            .startsWith(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showResults(context);
            query = suggestionList[index]['country'];
          },
          title: Text(suggestionList[index]['country']),
        );
      },
    );
  }
}
