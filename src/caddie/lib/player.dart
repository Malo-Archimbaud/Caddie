import 'package:caddie/clubs.dart';

class Player {
  String name;
  List<Clubs> clubs;
  List<int> maxDistances;

  Player({required this.name, required this.clubs, required this.maxDistances});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      clubs: List<Clubs>.from(json['clubs'].map((club) => Clubs.values.firstWhere((e) => e.name == club))),
      maxDistances: List<int>.from(json['maxDistances']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'clubs': clubs.map((club) => club.toString().split('.').last).toList(),
      'maxDistances': maxDistances,
    };
  }

  int getNbClubs() {
    return clubs.length;
  }

  void increaseDistance(int index) {
    maxDistances[index] += 5;
  }

  void addClub(String clubName, String maxDistance) {
    clubs.add(Clubs.values.firstWhere((e) => e.name == clubName));
    maxDistances.add(int.parse(maxDistance));
  }
}
