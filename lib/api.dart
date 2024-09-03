import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lookup/presentation/home.dart';

class ApiEndpoint extends StatefulWidget {
  final String searchdata;
  ApiEndpoint({this.searchdata = 'coimbatore', Key? key}) : super(key: key);

  @override
  _ApiEndpointState createState() => _ApiEndpointState();
}

class _ApiEndpointState extends State<ApiEndpoint> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(widget.searchdata);
  }

  Future<void> fetchData(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=f84bc3721080a64a90de6f90a5c854e9&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
     final sunriseEpoch = data['sys']['sunrise'];
      final sunsetEpoch = data['sys']['sunset'];
      
      // Convert sunrise and sunset from Unix timestamp to TimeOfDay
      final sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseEpoch * 1000);
      final sunset = DateTime.fromMillisecondsSinceEpoch(sunsetEpoch * 1000);
      
      // Format the times
      final sunriseTime = '${sunrise.hour}:${sunrise.minute.toString().padLeft(2, '0')}';
      final sunsetTime = '${sunset.hour}:${sunset.minute.toString().padLeft(2, '0')}';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(data, sunriseTime: sunriseTime, sunsetTime: sunsetTime)),
      );
  
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ?  Center(child: Image.asset('assets/clouds.gif',width: 170,))
            :  Center(child: Image.asset('assets/facolud.gif',width: 100,)),
      ),
    );
  }
}
