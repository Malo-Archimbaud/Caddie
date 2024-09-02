import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:caddie/localisation.dart';
import 'package:caddie/widgets/app_bar_widget.dart';
import 'point.dart';
import 'player.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  NewGameScreenState createState() => NewGameScreenState();
}

class NewGameScreenState extends State<NewGameScreen> {
  late Future<Position> _position;
  late Future<String> _nearestGolfCourse;
  late Player player;
  List<Point> area = [];
  String golfCourse = '';

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _position = determinePosition();
    _nearestGolfCourse = _getNearestGolfCourse();
    _loadPlayerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const AppBarWidget(),
            FutureBuilder<String>(
              future: _nearestGolfCourse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  golfCourse = snapshot.data!;
                  return _buildGolfCourseInfo();
                }
                return const Text('No golf course found nearby.');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _initializeGame(); // Re-trigger all calculations
          });
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Recalculate',
      ),
    );
  }

  Future<String> _getNearestGolfCourse() async {
    final coordinates = await _loadCoordinatesFromJson();
    final position = await _position;
    String nearestCourse = '';
    double minDistance = double.infinity;

    for (var entry in coordinates.entries) {
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        entry.value['latitude']!,
        entry.value['longitude']!,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestCourse = entry.key;
      }
    }

    return nearestCourse;
  }

  Future<Map<String, Map<String, double>>> _loadCoordinatesFromJson() async {
    try {
      final data = await rootBundle.loadString('assets/golf_coordinates.json');
      final Map<String, dynamic> jsonData = jsonDecode(data);

      return {
        for (var course in jsonData['golf_courses'])
          course['name']: {
            'latitude': course['coordinates']['latitude'],
            'longitude': course['coordinates']['longitude'],
          }
      };
    } catch (e) {
      throw Exception('Error loading golf courses from assets: $e');
    }
  }

  Widget _buildGolfCourseInfo() {
    return FutureBuilder<List<Point>>(
      future: _loadPointsFromJsonFile(golfCourse),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          area = snapshot.data!;
          return _buildPlayerInfo();
        }
        return const Text('No area data available.');
      },
    );
  }

  Widget _buildPlayerInfo() {
    return FutureBuilder<void>(
      future: _position,
      builder: (context, positionSnapshot) {
        if (positionSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (positionSnapshot.hasError) {
          return Text('Error: ${positionSnapshot.error}');
        }

        final position = positionSnapshot.data as Position;
        final Point currentPoint = Point(position.latitude, position.longitude);

        if (isPointInArea(currentPoint, area)) {
          return FutureBuilder<Point>(
            future: _loadAimPointFromJsonFile(golfCourse),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                final aimPoint = snapshot.data!;
                final distance = Geolocator.distanceBetween(
                  position.latitude,
                  position.longitude,
                  aimPoint.latitude,
                  aimPoint.longitude,
                );
                return _buildClubRecommendation(distance);
              }
              return const Text('No aim point data available.');
            },
          );
        } else {
          return const Text('You are outside the golf course area.');
        }
      },
    );
  }

  Widget _buildClubRecommendation(double distance) {
    return FutureBuilder<void>(
      future: _loadPlayerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading spinner
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          int clubIndex =
              player.maxDistances.lastIndexWhere((d) => d >= distance);
          if (clubIndex == -1) {
            clubIndex = 0; // Default to the first club if none match
          }

          return Text('You should use your ${player.clubs[clubIndex]}');
        }
      },
    );
  }

  Future<List<Point>> _loadPointsFromJsonFile(String courseName) async {
    final data =
        await rootBundle.loadString('assets/golf_courses/$courseName.json');
    final jsonData = json.decode(data);

    return [
      for (var point in jsonData['Holes'][0]['area']) Point(point[0], point[1])
    ];
  }

  Future<Point> _loadAimPointFromJsonFile(String courseName) async {
    final data =
        await rootBundle.loadString('assets/golf_courses/$courseName.json');
    final jsonData = json.decode(data);

    final latitude = jsonData['Holes'][0]['aim'][0];
    final longitude = jsonData['Holes'][0]['aim'][1];

    return Point(latitude, longitude);
  }

  Future<void> _loadPlayerData() async {
    try {
      final String data = await rootBundle.loadString('assets/player.json');
      final Map<String, dynamic> json = jsonDecode(data);
      // Ensure that player is assigned only once data is fully loaded
      player = Player.fromJson(json);
    } catch (e) {
      throw Exception("Error loading player data: $e");
    }
  }
}
