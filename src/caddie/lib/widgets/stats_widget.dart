import 'dart:convert';
import 'package:caddie/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  Player? player;

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  Future<void> _loadPlayerData() async {
  try {
    // Load the JSON file from assets
    final String data = await rootBundle.loadString('assets/player.json');

    // Decode the JSON data
    final Map<String, dynamic> json = jsonDecode(data);

    // Check if the JSON contains expected keys
    if (json['name'] == null || json['clubs'] == null || json['maxDistances'] == null) {
      throw Exception('Missing required keys in the JSON data');
    }

    // Initialize the Player object
    setState(() {
      player = Player.fromJson(json);
    });

  } catch (e) {
    // Handle errors
    print('Error loading player data: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return player == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              decorator(Column(children: [
                Row(children: [cell(text: 'Clubs'), cell(text: 'Distance max')]),
                for (var i = 0; i < player!.getNbClubs(); i++)
                  Row(children: [
                    cell(text: player!.clubs[i].name),
                    cell(
                        text: player!.maxDistances[i].toString(),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                final TextEditingController controller =
                                    TextEditingController();
                                return AlertDialog(
                                  content: TextFormField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                        labelText: 'Nouvelle distance'),
                                    keyboardType: TextInputType.number,
                                    onFieldSubmitted: (value) {
                                      setState(() {
                                        player!.maxDistances[i] =
                                            int.parse(value);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          player!.maxDistances[i] =
                                              int.parse(controller.text);
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
              player!.addClub(
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
