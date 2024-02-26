import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final cities = [
    "New York",
    "Los Angeles",
    "Chicago",
    "Houston",
    "Philadelphia",
    "Phoenix",
    "San Antonio",
    "San Diego",
    "Dallas",
    "San Jose",
    "Austin",
    "Jacksonville",
    "San Francisco",
    "Columbus",
    "Fort Worth",
    "Charlotte",
    "Detroit",
    "El Paso",
    "Memphis",
    "Boston",
    "Seattle",
    "Denver",
    "Washington",
    "Nashville",
    "Baltimore",
    "Louisville",
    "Portland",
    "Oklahoma City",
    "Milwaukee",
    "Las Vegas",
    "Albuquerque",
    "Tucson",
    "Fresno",
    "Sacramento",
    "Long Beach",
    "Kansas City",
    "Mesa",
    "Virginia Beach",
    "Atlanta",
    "Colorado Springs",
    "Omaha",
    "Raleigh",
    "Miami",
    "Oakland",
    "Minneapolis",
    "Tulsa",
    "Cleveland",
    "Wichita",
    "Arlington",
    "New Orleans",
    "Bakersfield",
    "Tampa",
    "Honolulu",
    "Anaheim",
    "Aurora",
    "Santa Ana",
    "St. Louis",
    "Riverside",
    "Corpus Christi",
    "Lexington",
    "Pittsburgh",
    "Anchorage",
    "Stockton",
    "Cincinnati",
    "St. Paul",
    "Toledo",
    "Newark",
    "Greensboro",
    "Plano",
    "Henderson",
    "Lincoln",
    "Buffalo",
    "Fort Wayne",
    "Jersey City",
    "Chula Vista",
    "Norfolk",
    "Orlando",
    "Chandler",
    "Laredo",
    "Madison",
    "Durham",
    "Lubb"
  ];
  var recentCities = ["New York", "Los Angeles"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Card(
          child: Center(child: Text(query)),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: const Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
