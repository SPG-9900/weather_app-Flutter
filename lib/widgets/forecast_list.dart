import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/providers/weather_provider.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final forecast = weatherProvider.forecast;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '3-DAYS FORECAST',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              return _buildForecastCard(context, forecast[index], weatherProvider.isCelsius);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForecastCard(BuildContext context, Weather weather, bool isCelsius) {
    final temperature = isCelsius ? weather.temperature : (weather.temperature * 9 / 5) + 32;
    final unit = isCelsius ? '°C' : '°F';

    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${weather.cityName}, ${weather.country}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getWeatherIcon(weather.icon),
                  size: 36,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  '${temperature.toStringAsFixed(1)}$unit',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip('Humidity', '${weather.humidity}%'),
                _buildInfoChip('Wind', '${weather.windSpeed} m/s'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
IconData _getWeatherIcon(String iconCode) {
  switch (iconCode) {
    case '01d':
    case '01n':
      return Icons.wb_sunny; 
    case '02d':
    case '02n':
      return Icons.cloud_queue; 
    case '03d':
    case '03n':
    case '04d':
    case '04n':
      return Icons.cloud; 
    case '09d':
    case '09n':
    case '10d':
    case '10n':
      return Icons.grain;
    case '11d':
    case '11n':
      return Icons.thunderstorm; 
    case '13d':
    case '13n':
      return Icons.ac_unit; 
    case '50d':
    case '50n':
      return Icons.foggy; 
    default:
      return Icons.error; 
  }
}

}
