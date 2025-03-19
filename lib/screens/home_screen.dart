import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/widgets/current_weather.dart';
import 'package:weather/widgets/forecast_list.dart';
import 'package:weather/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.transparent,
        title: const Text('WEATHER'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
              weatherProvider.fetchWeather(weatherProvider.city);
            },
          ),
          IconButton(
            icon: const Icon(Icons.thermostat),
            onPressed: () {
              final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
              weatherProvider.toggleUnit();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SearchBarBox(),
          Expanded(
            child: Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (weatherProvider.error.isNotEmpty) {
                  return Center(child: Text(weatherProvider.error));
                }
                if (weatherProvider.currentWeather == null) {
                  return const Center(child: Text('No weather data available'));
                }
                return RefreshIndicator(
                  onRefresh: () => weatherProvider.fetchWeather(weatherProvider.city),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        CurrentWeather(),
                        ForecastList(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
