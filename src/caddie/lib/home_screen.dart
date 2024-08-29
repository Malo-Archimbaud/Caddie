import 'package:caddie/new_game.dart';
import 'package:flutter/material.dart';
import 'package:caddie/widgets/app_bar_widget.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class BackgroundImages {
  final List<String> images = [
    'assets/background_golf_1.jpg',
    'assets/background_golf_2.jpg',
    'assets/background_golf_3.jpg',
  ];
}

class _HomeScreenState extends State<HomeScreen> {
  final random = Random();
  final String image = BackgroundImages().images[Random().nextInt(3)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewGameScreen()),
                              );
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
