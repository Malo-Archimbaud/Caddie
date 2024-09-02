import 'package:caddie/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:caddie/widgets/saved_games_widget.dart';
import 'package:flutter/services.dart';

class SavedGames extends StatefulWidget {
  const SavedGames({super.key});

  @override
  State<SavedGames> createState() => _SavedGamesState();
}

class _SavedGamesState extends State<SavedGames> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(children: [
        AppBarWidget(),
        Text('Saved Games'),
        SavedGamesWidget()
      ])),
    );
  }
}
