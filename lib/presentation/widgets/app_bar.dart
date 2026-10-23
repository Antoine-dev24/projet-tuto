import 'package:flutter/material.dart';
import 'package:projet_tuto/routes.dart';

// Below this width the links don't fit: we switch to the burger menu.
const mobileBreakpoint = 700.0;

class DotaTopBar extends StatelessWidget {
  const DotaTopBar({required this.title, super.key});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    // We look at the available width, not at the platform:
    // the web version opened on a phone also gets the burger.
    final isMobile = MediaQuery.sizeOf(context).width < mobileBreakpoint;

    return Container(
      height: 56, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(bottom: BorderSide(color: Color(0xFF2A2E36))),
      ),
      // Row is a horizontal, linear layout.
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              tooltip: 'Navigation menu',
              // Scaffold.of finds the closest Scaffold above this widget
              // and slides its "drawer" in from the left.
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          // Expanded expands its child
          // to fill the available space.
          Expanded(child: title),
          if (!isMobile)
            for (final item in AppRoutes.menu) _NavLink(item: item),
        ],
      ),
    );
  }
}

// One link of the desktop bar, underlined in red when it is the current page.
class _NavLink extends StatelessWidget {
  const _NavLink({required this.item});

  final NavItem item;

  @override
  Widget build(BuildContext context) {
    final isActive = AppRoutes.current(context) == item.route;

    return TextButton(
      onPressed: () => AppRoutes.go(context, item.route),
      style: TextButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.white54,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(), // square, no pill shape
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? const Color(0xFFE5322D) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          item.label,
          style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2),
        ),
      ),
    );
  }
}
