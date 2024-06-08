import 'package:caddie/clubs.dart';
import 'package:caddie/player.dart';
import 'package:flutter/material.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  @override
  Widget build(BuildContext context) {
    Player player = Player(
      name: 'Malo',
      clubs: [
        Clubs.driver,
        Clubs.hybride5,
        Clubs.fer5,
        Clubs.fer6,
        Clubs.fer7,
        Clubs.fer8,
        Clubs.fer9,
        Clubs.pw,
        Clubs.sw,
        Clubs.putter
      ],
      maxDistances: [220, 170, 150, 140, 130, 120, 110, 80, 50, 25],
    );

    return Column(
          children: [
    decorator(Column(children: [
      Row(children: [cell(text: 'Clubs'), cell(text: 'Distance max')]),
      for (var i = 0; i < player.getNbClubs(); i++)
        Row(children: [
          cell(text: player.clubs[i].name),
          cell(
              text: player.maxDistances[i].toString(),
              onPressed: () {
                setState(() {
                  player.increaseDistance(i);
                });
              })
        ]),
    ])),
    ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: addClubScreen(player),
              );
            });
      },
      child: const Text('Ajouter un club'),
    )
          ],
        );
  }

  Widget cell({required String text, VoidCallback? onPressed}) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
                child: Text(text, style: const TextStyle(fontSize: 20)))));
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

  Widget addClubScreen(Player player) {
    String clubName = '';
    String maxDistance = '';
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nom du club'),
          onChanged: (value) {
            clubName = value;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Distance max'),
          onChanged: (value) {
            maxDistance = value;
          },
        ),
        ElevatedButton(
          onPressed: () {
            player.addClub(clubName, maxDistance);
            Navigator.of(context).pop();
          },
          child: const Text('Ajouter'),
        )
      ],
    );
  }
}
