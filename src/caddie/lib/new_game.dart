import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:caddie/localisation.dart';
import 'package:caddie/widgets/app_bar_widget.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  final Future<Position> _position = determinePosition();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppBarWidget()]),
        FutureBuilder<Position>(
            future: _position,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    'Latitude: ${snapshot.data?.latitude}, Longitude: ${snapshot.data?.longitude}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
            FutureBuilder<String>(
              future: compareCoordinates(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data ?? '');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
      ])),
    );
  }

  Future<String> compareCoordinates() async {
    final jsonCoordinates = await readCoordinatesFromJson();
    int count = 0;
    String name = '';
    return _position.then((position) {
      final currentLatitude = position.latitude;
      final currentLongitude = position.longitude;
  
      for (final entry in jsonCoordinates.entries) {
        final jsonCoordinate = entry.value;
        final jsonLatitude = jsonCoordinate['latitude'];
        final jsonLongitude = jsonCoordinate['longitude'];
  
        final distance = Geolocator.distanceBetween(currentLatitude, currentLongitude, jsonLatitude!, jsonLongitude!);
        if (distance < 1000) {
          count++;
          name = entry.key;
        }
      }
      return 'You are near $count golf courses, which is the $name';
    });
  }

  Future<Map<String, Map<String, double>>> readCoordinatesFromJson() async {
    try {
    String data = await rootBundle.loadString('assets/golf_coordinates.json');
    final Map<String, dynamic> jsonData = jsonDecode(data);

    final Map<String, Map<String, double>> golfCourseDict = {};
    for (var course in jsonData['golf_courses']) {
      final String name = course['name'];
      final double latitude = course['coordinates']['latitude'];
      final double longitude = course['coordinates']['longitude'];
      golfCourseDict[name] = {
        'latitude': latitude,
        'longitude': longitude,
      };
    }
    return golfCourseDict;
  } catch (e) {
    print('Error loading golf courses from assets: $e');
    return {};
  }
}
}