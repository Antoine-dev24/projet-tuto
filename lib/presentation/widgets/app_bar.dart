import 'package:flutter/material.dart';
import 'package:projet_tuto/routes.dart';

// Below this width the links don't fit: we switch to the burger menu.
const mobileBreakpoint = 700.0;

const _accent = Color(0xFFE5322D); // Dota red
const _live = Color(0xFF3DDC84); // green "open" dot

// Logo on the left, links right next to it, a status badge on the right.
// A thin red line glows under the bar.
class DotaTopBar extends StatelessWidget {
  const DotaTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // We look at the available width, not at the platform:
    // the web version opened on a phone also gets the burger.
    final isMobile = MediaQuery.sizeOf(context).width < mobileBreakpoint;

    return Column(
      // min: the Column only takes the height of the bar + the line.
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 64, // in logical pixels
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 32),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Color(0xFF0B0D10)],
            ),
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
              const _Logo(),
              if (!isMobile) ...[
                const SizedBox(width: 48),
                for (final item in AppRoutes.menu) _NavLink(item: item),
              ],
              // Spacer takes all the free space: the badge goes to the right.
              const Spacer(),
              if (!isMobile) const _SeasonBadge(),
            ],
          ),
        ),
        // Red in the middle, fading out on both sides.
        Container(
          height: 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2A2E36), _accent, Color(0xFF2A2E36)],
            ),
          ),
        ),
      ],
    );
  }
}

// Red "FD" square + name of the league. Clicking it goes back home.
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    // GestureDetector makes any widget clickable,
    // MouseRegion shows the "hand" cursor on the web.
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => AppRoutes.go(context, AppRoutes.welcome),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_accent, Color(0xFF7A1411)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.5),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: const Text(
                'FD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              // center: both lines stay vertically centered in the bar.
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FLUTTER DOTA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                  ),
                ),
                Text(
                  'LIGUE DES PGM',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// One link of the desktop bar. A red bar grows under it
// when it is the current page, a grey one when the mouse is over it.
// Stateful: it has to remember whether the mouse is over it.
class _NavLink extends StatefulWidget {
  const _NavLink({required this.item});

  final NavItem item;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = AppRoutes.current(context) == widget.item.route;
    final highlighted = isActive || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      // setState rebuilds the widget with the new value.
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => AppRoutes.go(context, widget.item.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated* widgets animate by themselves
              // every time one of their values changes.
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: highlighted ? Colors.white : Colors.white54,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
                child: Text(widget.item.label),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: 2,
                width: highlighted ? 24 : 0,
                decoration: BoxDecoration(
                  color: isActive ? _accent : Colors.white38,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// "INSCRIPTIONS OUVERTES" pill with a blinking green dot.
class _SeasonBadge extends StatelessWidget {
  const _SeasonBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: _live.withValues(alpha: 0.08),
        border: Border.all(color: _live.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          _BlinkingDot(),
          SizedBox(width: 8),
          Text(
            'INSCRIPTIONS OUVERTES',
            style: TextStyle(
              color: _live,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// A small dot fading in and out forever.
class _BlinkingDot extends StatefulWidget {
  const _BlinkingDot();

  @override
  State<_BlinkingDot> createState() => _BlinkingDotState();
}

// SingleTickerProviderStateMixin gives the "ticker" (a callback on each
// frame) that the AnimationController needs to run.
class _BlinkingDotState extends State<_BlinkingDot>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
    lowerBound: 0.25,
  )..repeat(reverse: true); // 0.25 -> 1 -> 0.25 -> ...

  // A controller must always be disposed, or it keeps ticking.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FadeTransition uses the controller value (0.25 to 1) as opacity.
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          color: _live,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
