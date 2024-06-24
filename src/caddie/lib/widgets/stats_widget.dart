import 'package:caddie/clubs.dart';
import 'package:caddie/player.dart';
import 'package:flutter/material.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  late Player player;

  @override
  void initState() {
    super.initState();
    player = Player(
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
  }

  @override
  Widget build(BuildContext context) {
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
                    // When the user taps on a distance, he can type the new distance
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController controller = TextEditingController();
                          return AlertDialog(
                            content: TextFormField(
                              controller: controller,
                              decoration: const InputDecoration(
                                  labelText: 'Nouvelle distance'),
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (value) {
                                setState(() {
                                  player.maxDistances[i] = int.parse(value);
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    player.maxDistances[i] = int.parse(controller.text);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
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
                    content: addClubScreen(),
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

  Widget addClubScreen() {
    final TextEditingController clubNameController = TextEditingController();
    final TextEditingController maxDistanceController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: clubNameController,
          decoration: const InputDecoration(labelText: 'Nom du club'),
        ),
        TextFormField(
          controller: maxDistanceController,
          decoration: const InputDecoration(labelText: 'Distance max'),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              player.addClub(
                clubNameController.text,
                maxDistanceController.text,
              );
            });
            Navigator.of(context).pop();
          },
          child: const Text('Ajouter'),
        )
      ],
    );
  }
}
