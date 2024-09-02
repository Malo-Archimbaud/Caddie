import 'package:caddie/home_screen.dart';
import 'package:caddie/saved_games.dart';
import 'package:go_router/go_router.dart';
import 'package:caddie/stats.dart';
import 'package:caddie/rules.dart';
import 'package:caddie/new_game.dart';

final routes = GoRouter(routes: [
  GoRoute(
    name: 'home',
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    name: 'new-game',
    path: '/new-game',
    builder: (context, state) => const NewGameScreen(),
  ),
  GoRoute(
    name: 'stats',
    path: '/stats',
    builder: (context, state) => const StatsScreen(),
  ),
  GoRoute(
    name: 'saved-games',
    path: '/saved-games',
    builder: (context, state) => const SavedGames(),
  ),
  GoRoute(
    name: 'rules',
    path: '/rules',
    builder: (context, state) => const RulesScreen(),
  )
]);
