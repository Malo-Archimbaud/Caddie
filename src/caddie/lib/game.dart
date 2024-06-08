class Game {
  late String date; 
  late String place;
  late List<int> pars;
  late List<int> scores;

  Game({required this.date, required this.place, required this.pars, required this.scores});

  int get totalScore {
    int total = 0;
    for (int i = 0; i < pars.length; i++) {
      total += scores[i];
    }
    return total;
  }
  int get totalPar {
    int total = 0;
    for (int i = 0; i < pars.length; i++) {
      total += pars[i];
    }
    return total;
  }

  String getDate() {
    return date;
  }
  String getPlace() {
    return place;
  }
  List<int> getPars() {
    return pars;
  }
  List<int> getScores() {
    return scores;
  }
}

class Games extends Iterable<Game> {
  List<Game> games = [];

  void addGame(Game game) {
    games.add(game);
  }

  void removeGame(Game game) {
    games.remove(game);
  }

  List<Game> getGames() {
    return games;
  }

  @override
  Iterator<Game> get iterator => games.iterator;
}