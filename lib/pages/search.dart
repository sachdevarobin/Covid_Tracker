import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);
  @override
  List<Widget> buildActions(BuildContext context) {
    // it is on the right side of the title..ex- clearing the query
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }) //iconButton
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //it's on left side of the title example we need exit button form the search bar
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    {
      final suggestionList = query.isEmpty
          ? countryList
          : countryList
              .where((element) =>
                  element['country'].toString().toLowerCase().startsWith(query))
              .toList();

      return ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.grey[200],
              child: Container(
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            suggestionList[index]['country'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Image.network(
                            suggestionList[index]['countryInfo']['flag'],
                            height: 50,
                            width: 60,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'CONFIRMED:' +
                                suggestionList[index]['cases'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          Text(
                            'ACTIVE:' +
                                suggestionList[index]['active'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(
                            'RECOVERED:' +
                                suggestionList[index]['recovered'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            'DEATHS:' +
                                suggestionList[index]['deaths'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            );
          });
    }
  }
}
