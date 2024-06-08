import 'package:caddie/home_screen.dart';
import 'package:caddie/saved_games.dart';
import 'package:go_router/go_router.dart';
import 'package:caddie/stats.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
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
  ]
);
