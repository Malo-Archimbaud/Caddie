import 'package:caddie/clubs.dart';

class Player {
  String name;
  List<Clubs> clubs;
  List<int> maxDistances;

  Player({required this.name, required this.clubs, required this.maxDistances});

  int getNbClubs() {
    return clubs.length;
  }

  void increaseDistance(int index) {
    maxDistances[index] += 5;
  }

  void addClub(String clubName, String maxDistance){
    clubs.add(Clubs.values.firstWhere((e) => e.name == clubName));
    maxDistances.add(int.parse(maxDistance));
  }
}