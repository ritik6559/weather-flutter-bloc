import 'package:flutter/material.dart';
import 'package:weatherapp/screens/weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _keyBoardContoller = TextEditingController();
  @override
  void dispose() {
    _keyBoardContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _keyBoardContoller,
          autocorrect: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.white,
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 3),
            ),
            label: const Text('Search....'),
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        WeatherScreen(city: _keyBoardContoller.text)));
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
