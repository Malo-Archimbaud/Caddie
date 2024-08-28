import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:caddie/player.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  late Player player;
  bool _isPlayerLoaded = false;
  String? _filePath; // To store the file path for debugging

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  Future<void> _loadPlayerData() async {
    try {
      final String data = await rootBundle.loadString('assets/player.json');
      final Map<String, dynamic> json = jsonDecode(data);
      setState(() {
        player = Player.fromJson(json);
        _isPlayerLoaded = true;
      });
    } catch (e) {
      print("Error loading player data: $e");
    }
  }

  Future<void> _savePlayerData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/player.json');
      _filePath = file.path; // Store file path for debugging

      final String json = jsonEncode(player.toJson());

      await file.writeAsString(json);
      print("Player data saved successfully at: $_filePath");
    } catch (e) {
      print("Error saving player data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isPlayerLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

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
                                  player.maxDistances[i] = int.parse(value);
                                });
                                _savePlayerData(); // Save data after modification
                                Navigator.of(context).pop();
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    player.maxDistances[i] =
                                        int.parse(controller.text);
                                  });
                                  _savePlayerData(); // Save data after modification
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
            _savePlayerData(); // Save data after adding a new club
            Navigator.of(context).pop();
          },
          child: const Text('Ajouter'),
        )
      ],
    );
  }
}
