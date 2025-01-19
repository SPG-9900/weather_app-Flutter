import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';

class SearchBarBox extends StatefulWidget {
  const SearchBarBox({super.key});

  @override
  State<SearchBarBox> createState() => _SearchBarBoxState();
}

class _SearchBarBoxState extends State<SearchBarBox> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _searchCity(BuildContext context) async {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });

      try {
        await Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error searching for "$city". Please try again.')),
        );
      } finally {
        setState(() {
          _isSearching = false;
          _controller.clear(); // Clear the input after fetching data
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (_) => _searchCity(context),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _isSearching ? null : () => _searchCity(context),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: _isSearching
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Search'),
          ),
        ],
      ),
    );
  }
}
