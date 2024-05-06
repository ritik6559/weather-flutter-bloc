import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/components/constants.dart';
import '../components/weather_screen_items.dart';
import '../components/additional_info_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        ),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

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
              setState(() {
                weather = getCurrentWeather(); //to get a reloading effect we are using set state and initailizing weather with every click.
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            weather, //insted of passing  getweather()firectly what flutter suggest is to pass a variable folsing that function value.
        builder: (context, snapshot) {
          //snapshot is used to handle state is your app like loading state, data state, error state.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator
                    .adaptive()); //with adaptive it will give acc to OS.
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
                    snapshot.error.toString())); //to print the error on screen.
          }

          final data = snapshot.data!;

          final currentData = data['list'][0];
          final currentTemperature = currentData['main']['temp'];
          final currentSky = currentData['weather'][0]['main'];
          final currentHumidity = currentData['main']['humidity'].toString();
          final currentSpeed = currentData['wind']['speed'].toString();
          final currentPressure = currentData['main']['pressure'].toString();

          return Padding(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemperature K',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 32),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 62,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '$currentSky',
                                  style: const TextStyle(fontSize: 25),
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
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 1; i <= 5;i++)//now we are making 5 data but if we want to make 40 widgets it wouls be a problem because then all widgets will load at the same time but we want to load them when we are scrolling so for this we will listview.builder.
                //         HourlyForeCastItem(// we dont need brackets for for loop in flutter to represent more values we use ...[content].
                //           icon: data['list'][i]['weather'][0]['main'] == 'Clouds' || data['list'][i]['weather'][0]['main'] == 'Rain'? Icons.cloud:Icons.sunny,
                //           time: data['list'][i]['dt'].toString(),
                //           temperature: data['list'][i]['main']['temp'].toString() ,
                //         ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 155,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 39,
                    itemBuilder: (context, index) {
                      //beacause index starts from 0 therefore index +1;
                      final hourlyForeCast = data['list'][index + 1];

                      final hourlySky =
                          data['list'][index + 1]['weather'][0]['main'];

                      final time = DateTime.parse(
                          hourlyForeCast['dt_txt']); // to import intl package.

                      return HourlyForeCastItem(
                          icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          temperature:
                              hourlyForeCast['main']['temp'].toString(),
                          time: DateFormat.j().format(time));
                    },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditonalInfpItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity,
                    ),
                    AdditonalInfpItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentSpeed,
                    ),
                    AdditonalInfpItem(
                      icon: Icons.beach_access,
                      value: currentPressure,
                      label: 'Pressure',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
