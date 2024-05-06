import 'dart:ui';
import 'package:flutter/material.dart';
import '../components/weather_screen_items.dart';
import '../components/additional_info_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            //gesture control doesn't give splash effect so to avoid this we use INKwELL to get advantage of both we use iconbutton
            onPressed: () {
            },
            icon: const Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  //to add a nice merging effect
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              '300.67 K',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 32),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.cloud,
                              size: 62,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Rain',
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Weather Forecast',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForeCastItem(
                    icon: Icons.cloud,
                    time: "3:00",
                    temperature: "301 K",
                  ),
                  HourlyForeCastItem(
                    icon: Icons.cloud,
                    time: "4:00",
                    temperature: "290 K",
                  ),
                  HourlyForeCastItem(
                    icon: Icons.cloud,
                    time: "5:00",
                    temperature: "308 K",
                  ),
                  HourlyForeCastItem(
                    icon: Icons.cloud,
                    time: "6:00",
                    temperature: "323 K",
                  ),
                  HourlyForeCastItem(
                    icon: Icons.cloud,
                    time: "7:00",
                    temperature: "333 K",
                  ),
                  HourlyForeCastItem(
                    icon: Icons.cloud,
                    time: "8:00",
                    temperature: "299 K",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Additional Information',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditonalInfpItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '94',
                ),
                AdditonalInfpItem(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '7.5',
                ),
                AdditonalInfpItem(
                  icon: Icons.beach_access,
                  value: '1000',
                  label: 'Pressure',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
