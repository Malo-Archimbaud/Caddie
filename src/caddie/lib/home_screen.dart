import 'package:caddie/localisation.dart';
import 'package:flutter/material.dart';
import 'package:caddie/widgets/app_bar_widget.dart';
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
        body: Stack(children: [
          Positioned.fill(child: Image.asset('assets/background_golf_1.jpg', fit: BoxFit.cover)),
      Column(
        children: [
          const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [AppBarWidget()]),
          const Expanded(child: Column(),),
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Nouvelle partie'),
                      content: const Text(
                          'Voulez-vous commencer une nouvelle partie ?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Non')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/newGame');
                            },
                            child: const Text('Oui'))
                      ],
                    );
                  });
            },
            child: const Text('Commencer une nouvelle partie'),
          ),
        ],
      ),
    ]));
  }

  Widget newGameScreen() {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [AppBarWidget()]),
          const Text('Nouvelle partie'),
          ElevatedButton(
            onPressed: () {
              // add logic
            },
            child: const Text('Start New Game'),
          )
        ],
      ),
    ));
  }
}

/*FutureBuilder<Position>(
            future: _position,
            builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                    'Position: ${snapshot.data!.latitude}, ${snapshot.data!.longitude}');
              }
            },
          ),*/
