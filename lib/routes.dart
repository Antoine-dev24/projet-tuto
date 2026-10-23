import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/screens/home_screen.dart';
import 'package:projet_tuto/presentation/screens/welcome_screen.dart';

// All the app's pages, each one reachable by a name (a path, like on the web).
// Navigator.pushNamed(context, AppRoutes.cards) opens the cards page,
// Navigator.pop(context) comes back.
class AppRoutes {
  // Private constructor: this class only holds constants, no instances.
  AppRoutes._();

  static const welcome = '/';
  static const cards = '/cards';

  // Given to MaterialApp(routes: ...): name -> function that builds the page.
  static final Map<String, WidgetBuilder> routes = {
    welcome: (_) => const SafeArea(child: WelcomeScreen()),
    cards: (_) => const SafeArea(child: HomeScreen()),
  };

  // The menu entries, shared by the burger menu and the desktop bar:
  // add a page here and it shows up in both.
  static const menu = [
    NavItem(label: 'ACCUEIL', icon: Icons.home_rounded, route: welcome),
    NavItem(label: 'HÉROS', icon: Icons.style_rounded, route: cards),
  ];

  // Name of the page currently displayed (e.g. '/cards').
  static String? current(BuildContext context) =>
      ModalRoute.of(context)?.settings.name;

  // Menu navigation: back to the welcome page, then push the target on top.
  // The stack never grows beyond "welcome -> one page",
  // so the back button always leads to the welcome page.
  static void go(BuildContext context, String route) {
    if (route == current(context)) return;
    final navigator = Navigator.of(context);
    navigator.popUntil((r) => r.isFirst);
    if (route != welcome) navigator.pushNamed(route);
  }
}

class NavItem {
  const NavItem({required this.label, required this.icon, required this.route});

  final String label;
  final IconData icon;
  final String route;
}
