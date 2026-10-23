import 'package:flutter/material.dart';
import 'package:projet_tuto/routes.dart';

// The burger menu: a panel that slides in from the left.
// Given to Scaffold(drawer: ...), opened by the burger button of DotaTopBar.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const _accent = Color(0xFFE5322D);

  @override
  Widget build(BuildContext context) {
    final current = AppRoutes.current(context);

    return Drawer(
      backgroundColor: const Color(0xFF0B0D10),
      shape: const RoundedRectangleBorder(), // square corners
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 32, 24, 32),
              child: Text(
                'FLUTTER\nDOTA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  height: 0.95,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ),
            for (final item in AppRoutes.menu)
              _DrawerItem(item: item, isActive: item.route == current),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.item, required this.isActive});

  final NavItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.white : Colors.white54;

    // A red bar on the left marks the current page.
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withValues(alpha: 0.05) : null,
        border: Border(
          left: BorderSide(
            color: isActive ? AppDrawer._accent : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(item.icon, color: isActive ? AppDrawer._accent : color),
        title: Text(
          item.label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        onTap: () {
          // Close the panel first, then change page.
          Scaffold.of(context).closeDrawer();
          AppRoutes.go(context, item.route);
        },
      ),
    );
  }
}
