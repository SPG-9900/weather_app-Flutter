import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather.dart';

class WeatherService {
  static const String _apiKey = '8de379a1f17c630832a0297160028f64';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> getWeather(String city) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Weather>> getForecast(String city) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/forecast?q=$city&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> list = data['list'];
      return list
          .where((item) => item['dt_txt'].toString().contains('12:00:00'))
          .take(3)
          .map((item) => Weather.fromJson({...item, 'name': data['city']['name'], 'sys': {'country': data['city']['country']}}))
          .toList();
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}

