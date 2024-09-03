import 'package:flutter/material.dart';
import 'package:lookup/arcProgress.dart';
import 'package:lookup/widgets/bottomsheet.dart';
import 'package:lookup/widgets/statusofWeather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyStack extends StatelessWidget {
  final bool isweather;
  final Map<String, dynamic> datastored;
  final double screenWidth;
  final String formattedDate;
   final String sunriseTime;
  final String sunsetTime;
  const BodyStack( this.isweather, this.datastored,this.screenWidth,this.formattedDate,this.sunriseTime,this.sunsetTime,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBottomsheet(
          isweather: isweather,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: isweather
                        ? const LinearGradient(
                            colors: [
                              Color(0xFFFFD700), // Gold
                              Color.fromARGB(255, 237, 225, 160), // Light Gold
                              Colors.white,
                              Colors.white,
                              Colors.white,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          )
                        : const LinearGradient(
                            colors: [
                              Color(0xFFbdc3c7), // Silver
                              Color(0xFF2c3e50), // Midnight Blue
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.all(30),
                  width: screenWidth,
                  height: 700,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.locationDot,
                                    size: 20,
                                    color: isweather
                                        ? Colors.black
                                        : Colors.white),
                                const SizedBox(width: 7),
                                Text(datastored['name'],
                                    style: GoogleFonts.cabin(
                                        fontSize: 27,
                                        color: isweather
                                            ? Colors.black
                                            : Colors.white)),
                                const SizedBox(width: 7),
                              ],
                            ),
                            Text(formattedDate,
                                style: GoogleFonts.cabin(
                                    fontSize: 16,
                                    color: isweather
                                        ? Colors.black
                                        : Colors.white)),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: isweather
                                  ? Image.asset(
                                      'assets/sun.gif',
                                      width: 180,
                                    )
                                  : const Icon(FontAwesomeIcons.cloudRain,
                                      size: 90),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                  '${datastored['main']['temp'].toInt()}°',
                                  style: GoogleFonts.cabin(
                                      fontSize: 100,
                                      color: isweather
                                          ? const Color.fromARGB(255, 6, 6, 75)
                                          : Colors.white)),
                            ),
                            Text(datastored['weather'][0]['description'],
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 24,
                                    color: isweather
                                        ? const Color.fromARGB(255, 6, 6, 75)
                                        : Colors.white)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Feels like ${datastored['main']['feels_like']}°',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 15,
                                    color: isweather
                                        ? const Color.fromARGB(255, 6, 6, 75)
                                        : Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Statusofweather(isweather, datastored,screenWidth), //

              // third column
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isweather
                          ? const Color.fromARGB(255, 237, 225, 160)
                          : const Color(0xFF0a2f5b).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: const EdgeInsets.all(30),
                    width: screenWidth,
                    height: 350,
                    child: SunArcAnimation(
                      isweather: isweather,
                      sunrisseTime: sunriseTime,
                      sunsetTime: sunsetTime,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
