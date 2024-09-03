import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Statusofweather extends StatelessWidget {
  final bool isweather;
  final Map<String, dynamic> datastored;
  final double screenWidth;
  const Statusofweather(this.isweather, this.datastored,this.screenWidth, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: Container(
            decoration: BoxDecoration(
              color: isweather
                  ? const Color.fromARGB(255, 237, 225, 160)
                  : const Color(0xFF0a2f5b).withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            margin: const EdgeInsets.all(30),
            width: screenWidth,
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/windy(1).png',
                            width: 50,
                            color: isweather
                                ? Colors.lightBlue
                                : const Color.fromARGB(255, 6, 6, 75),
                          ),
                          const SizedBox(height: 2),
                          Text('Wind: ${datastored['wind']['speed']} km/h',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                  color: isweather
                                      ? const Color.fromARGB(255, 6, 6, 75)
                                      : Colors.white)),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/humidity.png',
                            width: 50,
                            color: isweather
                                ? Colors.lightBlue
                                : const Color.fromARGB(255, 6, 6, 75),
                          ),
                          const SizedBox(height: 2),
                          Text('Humidity: ${datastored['main']['humidity']}%',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                  color: isweather
                                      ? const Color.fromARGB(255, 6, 6, 75)
                                      : Colors.white))
                        ],
                      ),
                      const SizedBox(width: 25),
                      Column(
                        children: [
                          Image.asset(
                            'assets/temperature.png',
                            width: 50,
                            color: isweather
                                ? Colors.lightBlue
                                : const Color.fromARGB(255, 6, 6, 75),
                          ),
                          const SizedBox(height: 2),
                          Text(
                              'Feels like: ${datastored['main']['feels_like']}°',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                  color: isweather
                                      ? const Color.fromARGB(255, 6, 6, 75)
                                      : Colors.white)),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/uv.png',
                            width: 50,
                            color: isweather
                                ? Colors.lightBlue
                                : const Color.fromARGB(255, 6, 6, 75),
                          ),
                          const SizedBox(height: 2),
                          Text('UV: 81%',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                  color: isweather
                                      ? const Color.fromARGB(255, 6, 6, 75)
                                      : Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
