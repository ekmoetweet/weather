import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/data/model/weather_model.dart';

abstract class Repository {
  Future<Weather> fetchWeather(String latLng);
}

class WeatherRepository implements Repository {
  @override
  Future<Weather> fetchWeather(String latLng) async {
    final response = await http.get(Uri.parse('https://www.7timer.info/bin/astro.php?$latLng&ac=0&unit=metric&output=json&tzshift=0'), headers: {
      "Accept": "application/json",
      "content-type": "application/json",
    });

    if (response.statusCode == 200) {
      Weather weather = Weather.fromJson(json.decode(response.body));

      return weather;
    } else {
      throw NetworkException();
    }
  }
}

class NetworkException implements Exception {}
