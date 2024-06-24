import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          icon: const Icon(Icons.golf_course),
          onPressed: () {
            GoRouter.of(context).go('/');
          }),
      IconButton(
          icon: const Icon(Icons.list_alt),
          onPressed: () {
            GoRouter.of(context).go('/saved-games');
          }),
      IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            GoRouter.of(context).go('/stats');
          }),
      IconButton(
          icon: const Icon(Icons.menu_book),
          onPressed: () {
            GoRouter.of(context).go('/rules');
          }),
      IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            GoRouter.of(context).go('/settings');
          }),
    ]));
  }
}
