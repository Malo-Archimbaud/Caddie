import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:caddie/localisation.dart';
import 'package:caddie/widgets/app_bar_widget.dart';
import 'point.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  NewGameScreenState createState() => NewGameScreenState();
}

class NewGameScreenState extends State<NewGameScreen> {
  final Future<Position> _position = determinePosition();
  List<Point> area = [];
  String golfCourse = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppBarWidget()]),
        FutureBuilder<String>(
          future: compareCoordinates(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              late double latitude = 0;
              late double longitude = 0;
              golfCourse = snapshot.data!;
              return FutureBuilder<List<Point>>(
                future: loadPointsFromJsonFile(golfCourse),
                builder: (context, snapshot) {
                  Point p;
                  if (snapshot.hasData) {
                    area = snapshot.data!;
                    _position.then((position) {
                      latitude = position.latitude;
                      longitude = position.longitude;
                    });
                    if (latitude != 0 && longitude != 0) {
                      p = Point(latitude, longitude);
                      bool b = isPointInArea(p, area);
                      
                      return Text('Golf course: $b');
                    }
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ])),
    );
  }

  Future<String> compareCoordinates() async {
    final jsonCoordinates = await readCoordinatesFromJson();
    String name = '';
    return _position.then((position) {
      final currentLatitude = position.latitude;
      final currentLongitude = position.longitude;

      for (final entry in jsonCoordinates.entries) {
        final jsonCoordinate = entry.value;
        final jsonLatitude = jsonCoordinate['latitude'];
        final jsonLongitude = jsonCoordinate['longitude'];

        final distance = Geolocator.distanceBetween(
            currentLatitude, currentLongitude, jsonLatitude!, jsonLongitude!);
        if (distance < 1000) {
          name = entry.key;
        }
      }
      return name;
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

  Future<List<Point>> loadPointsFromJsonFile(String name) async {
    final file = await rootBundle.loadString('assets/golf_courses/$name.json');
    final jsonData = json.decode(file);

    List<Point> points = [];

    for (var point in jsonData['Holes'][0]['area']) {
      final double latitude = point[0];
      final double longitude = point[1];
      points.add(Point(latitude, longitude));
    }

    return points;
  }
}
