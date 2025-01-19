import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final SharedPreferences prefs;
  final WeatherService _weatherService = WeatherService();

  Weather? _currentWeather;
  List<Weather> _forecast = [];
  String _city = '';
  bool _isLoading = false;
  String _error = '';
  bool _isCelsius = true;

  WeatherProvider(this.prefs) {
    _loadPreferences();
  }

  Weather? get currentWeather => _currentWeather;
  List<Weather> get forecast => _forecast;
  String get city => _city;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isCelsius => _isCelsius;

  void _loadPreferences() {
    _city = prefs.getString('lastCity') ?? 'Nashik';
    fetchWeather(_city); 
  }

  void toggleUnit() {
    _isCelsius = !_isCelsius;
    prefs.setBool('isCelsius', _isCelsius);
    notifyListeners();
  }

  Future<void> fetchWeather(String city) async {
    _currentWeather = null;
    _forecast = [];
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final weatherData = await _weatherService.getWeather(city);
      final forecastData = await _weatherService.getForecast(city);

      _currentWeather = weatherData;
      _forecast = forecastData;
      _city = city;

      prefs.setString('lastCity', city);
    } catch (e) {
      _error = 'Failed to fetch weather data for "$city". Please try again.';
      _currentWeather = null;
      _forecast = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
