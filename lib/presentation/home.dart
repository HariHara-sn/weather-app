import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lookup/api.dart';
import 'package:intl/intl.dart'; // for d m yy

import 'package:lookup/presentation/body_stack.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic> datastored;
  final String sunriseTime;
  final String sunsetTime;

  const HomePage(this.datastored,
      {required this.sunriseTime, required this.sunsetTime, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);

    // Determine if the weather is sunny
    bool isweather = datastored['weather'][0]['main'] == 'Clear' ||
        datastored['weather'][0]['main'] == 'Clouds';

    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
              isweather ? Colors.yellow[50] : const Color(0xFF0a2f5b),
          scrolledUnderElevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                child: Image.asset('assets/loc_dark.gif',
                    width: 30, color: isweather ? Colors.black : Colors.white),
                onTap: () {
                  showSearch(context: context, delegate: CitySearch());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.more_vert,
                  color: isweather ? Colors.black : Colors.white),
            )
          ],
          elevation: 0,
        ),
        backgroundColor:
            isweather ? Colors.yellow[50] : const Color(0xFF0a2f5b),
        body: BodyStack(isweather, datastored, screenWidth, formattedDate,
            sunriseTime, sunsetTime));
  }
}

class CitySearch extends SearchDelegate<String> {
  final cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
    'Dallas',
    'San Jose',
    'coimbatore',
    'chennai',
    'kovilpatti',
  ];

  final recentCities = [
    'San Francisco',
    'Seattle',
    'Boston',
    'Denver',
    'coimbatore',
    'chennai',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
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
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : cities
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          close(context, suggestionList[index]);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ApiEndpoint(searchdata: suggestionList[index])),
          );
        },
        leading: const Icon(Icons.location_city_rounded),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: GoogleFonts.fuzzyBubbles(
                color: Colors.black, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: GoogleFonts.fuzzyBubbles(color: Colors.black)),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
