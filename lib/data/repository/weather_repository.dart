import 'dart:convert';

import 'package:weatherapp/data/data_provider/weather_data_provider.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository({
    required this.weatherDataProvider,
  });
  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'London';

      final res = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(res);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
