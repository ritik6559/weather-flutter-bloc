import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import '../widgets/additional_info_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    super.key,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
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
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {

          if (state is WeatherFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is! WeatherSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final data = state.weatherModel;

          final currentTemperature = data.currentTemp;
          final currentSky = data.currentSky;
          final currentHumidity = data.currentHumidity;
          final currentSpeed = data.currentWindSpeed;
          final currentPressure = data.currentPressure;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          "Mumbai",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                                    currentSky == 'Clouds' ||
                                            currentSky == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 62,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    currentSky,
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
                  // SizedBox(
                  //   height: 155,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: 39,
                  //     itemBuilder: (context, index) {
                  //       //beacause index starts from 0 therefore index +1;
                  //       final hourlyForeCast = data['list'][index + 1];

                  //       final hourlySky =
                  //           data['list'][index + 1]['weather'][0]['main'];

                  //       final time = DateTime.parse(hourlyForeCast[
                  //           'dt_txt']); //we have to import intl package.

                  //       return HourlyForeCastItem(
                  //           icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                  //               ? Icons.cloud
                  //               : Icons.sunny,
                  //           temperature:
                  //               hourlyForeCast['main']['temp'].toString(),
                  //           time: DateFormat.j().format(time));
                  //     },
                  //   ),
                  // ),
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
                        value: currentHumidity.toString(),
                      ),
                      AdditonalInfpItem(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: currentSpeed.toString(),
                      ),
                      AdditonalInfpItem(
                        icon: Icons.beach_access,
                        value: currentPressure.toString(),
                        label: 'Pressure',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
