import 'package:flutter/material.dart';
import 'package:caddie/game.dart';

class SavedGamesWidget extends StatelessWidget {
  const SavedGamesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Games games = Games();
    games.addGame(Game(date: '26-05-2024',
    place: 'Golf de Bourges', 
    pars:[4,4,5,4,3,5,3,5,3,4,4,3,5,3,4,4,5,4], 
    scores: [3,4,6,4,4,4,3,5,3,4,4,3,5,4,4,3,5,4]));

    return Container(
        child: decorator(Column(
      children: [
        Row(
          children: [
            cell(text:''),
            for (var game in games) cell(text: game.date, width: 2),
            for (var game in games) cell(text: game.place, width: 14)
          ],
        ),
        Row(
          children: [
            cell(text: 'Trou'),
            for (var i = 1; i < 19; i++) cell(text: i.toString()),
            cell(text: 'Total')
          ],
        ),
        Row(children: [
          cell(text: 'Par'),
          for (var game in games) ...[
            for (var par in game.getPars()) cell(text: par.toString())
          ],
          for (var game in games) cell(text: game.totalPar.toString())
        ]),
        Row(children: [
          cell(text: 'Coups'),
          for (var game in games) ...[
            for (var score in game.getScores()) cell(text: score.toString())
          ],
          for (var game in games) cell(text: game.totalScore.toString())
        ]),
      ],
    )));
  }

  Widget cell({required String text, double? width, double? height}) {
    return Container(
        width: 39 + 39*(width ?? 0),
        height: 39 + 39*(height ?? 0),
        //padding: const EdgeInsets.all(8),
        //margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text(text, style: const TextStyle(fontSize: 10))));
  }

  Widget decorator(Widget child) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: child,
    );
  }
}
