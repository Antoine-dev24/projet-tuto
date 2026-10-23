import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/widgets/welcome/section.dart';
import 'package:projet_tuto/routes.dart';

// First section: hero pictures in the background, slogan, buttons, numbers.
class HeroSection extends StatelessWidget {
  const HeroSection({required this.onDiscover, super.key});

  // Called by the "COMMENT ÇA MARCHE" button (scrolls down the page).
  final VoidCallback onDiscover;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);

    // Stack paints its children on top of each other:
    // first the background, then the content.
    return Stack(
      children: [
        // Positioned.fill: the background takes the size of the content.
        const Positioned.fill(child: _HeroBackground()),
        WelcomeSection(
          verticalPadding: mobile ? 64 : 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Tag(text: 'SAISON 1  ·  INSCRIPTIONS OUVERTES'),
              const SizedBox(height: 28),
              Text(
                'LA LIGUE\nDES PGM.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: mobile ? 56 : 96,
                  height: 0.92,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Text(
                  'Trouve des joueurs de ton niveau, monte ton équipe et '
                  'grimpe le classement. Ici, chaque score est vérifié '
                  'avant de compter.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Wrap: the second button goes to the next line
              // when both don't fit side by side.
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  WelcomeButton(
                    label: "ENTRER DANS L'ARÈNE",
                    icon: Icons.play_arrow_rounded,
                    onPressed: () => AppRoutes.go(context, AppRoutes.cards),
                  ),
                  WelcomeButton(
                    label: 'COMMENT ÇA MARCHE',
                    icon: Icons.expand_more_rounded,
                    outlined: true,
                    onPressed: onDiscover,
                  ),
                ],
              ),
              SizedBox(height: mobile ? 48 : 72),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: const _Stats(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Four hero pictures side by side, darkened on the left and at the bottom
// so the text stays readable.
class _HeroBackground extends StatelessWidget {
  const _HeroBackground();

  static const _heroes = ['juggernaut', 'lina', 'axe', 'crystal_maiden'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.4,
          child: Row(
            // stretch: each picture takes the full height.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final hero in _heroes)
                Expanded(
                  child: Image.asset(
                    'assets/heroes/$hero.png',
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
        // Dark on the left (behind the text), transparent on the right.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                WelcomeColors.background,
                Color(0x99050607), // background at 60%
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Fades into the page background at the bottom.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, WelcomeColors.background],
              stops: [0.5, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}

// Small outlined label above the title.
class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: WelcomeColors.accent.withValues(alpha: 0.12),
        border: Border.all(color: WelcomeColors.accent),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: WelcomeColors.accent,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

// Three key numbers side by side.
class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _Stat(value: '5V5', label: 'FORMAT')),
        Expanded(child: _Stat(value: '100%', label: 'SCORES VÉRIFIÉS')),
        Expanded(child: _Stat(value: '0', label: 'TRICHE TOLÉRÉE')),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: WelcomeColors.accent, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
