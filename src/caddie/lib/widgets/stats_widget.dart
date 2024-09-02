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
      debugPrint("Error loading player data: $e");
    }
  }

  Future<void> _savePlayerData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/player.json');
      final String json = jsonEncode(player.toJson());

      await file.writeAsString(json);
      debugPrint("Player data saved successfully at: ${file.path}");
    } catch (e) {
      debugPrint("Error saving player data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isPlayerLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        _buildStatsTable(),
        ElevatedButton(
          onPressed: () => _showAddClubDialog(),
          child: const Text('Ajouter un club'),
        ),
      ],
    );
  }

  Widget _buildStatsTable() {
    return _decorator(
      Column(
        children: [
          Row(
            children: [
              _cell(text: 'Clubs'),
              _cell(text: 'Distance max'),
            ],
          ),
          for (int i = 0; i < player.getNbClubs(); i++)
            Row(
              children: [
                _cell(text: player.clubs[i].name),
                _cell(
                  text: player.maxDistances[i].toString(),
                  onPressed: () => _showEditDistanceDialog(i),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _showEditDistanceDialog(int index) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextFormField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Nouvelle distance'),
            keyboardType: TextInputType.number,
            onFieldSubmitted: (value) {
              _updateDistance(index, int.parse(value));
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                _updateDistance(index, int.parse(controller.text));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _updateDistance(int index, int newDistance) {
    setState(() {
      player.maxDistances[index] = newDistance;
    });
    _savePlayerData();
    Navigator.of(context).pop();
  }

  void _showAddClubDialog() {
    final clubNameController = TextEditingController();
    final maxDistanceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
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
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addNewClub(
                  clubNameController.text,
                  int.parse(maxDistanceController.text),
                );
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _addNewClub(String name, int maxDistance) {
    setState(() {
      player.addClub(name, maxDistance.toString());
    });
    _savePlayerData();
    Navigator.of(context).pop();
  }

  Widget _cell({required String text, VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _decorator(Widget child) {
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
