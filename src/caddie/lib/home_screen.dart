import 'package:caddie/localisation.dart';
import 'package:flutter/material.dart';
import 'package:caddie/widgets/app_bar.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<Position> _position = determinePosition();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const AppBarWidget(),
          const Text('Welcome to Caddie!'),
          
          FutureBuilder<Position>(
            future: _position,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                      'Location: ${snapshot.data?.latitude}, ${snapshot.data?.longitude}');
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    ));
  }
}
