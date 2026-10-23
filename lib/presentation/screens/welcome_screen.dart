import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/widgets/app_bar.dart';
import 'package:projet_tuto/presentation/widgets/app_drawer.dart';
import 'package:projet_tuto/routes.dart';

// Landing page: big title, three key numbers, one button to the cards.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _accent = Color(0xFFE5322D); // Dota red

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050607),
      // The burger menu, opened from DotaTopBar on small screens.
      drawer: const AppDrawer(),
      body: Column(
        children: [
          DotaTopBar(
            title: Text(
              'Flutter Dota',
              style: Theme.of(context).primaryTextTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          // The page itself takes all the space left under the bar.
          Expanded(child: _buildContent(context)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    // Stack paints its children on top of each other:
    // first the background, then the content.
    return Stack(
      fit: StackFit.expand,
      children: [
        const _HeroBackground(),
        // SingleChildScrollView: the content can scroll
        // if the screen is too short (small phone, landscape).
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Center(
            // Keeps the content readable on wide screens.
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Tag(text: 'SAISON 1  ·  LIGUE DES PGM'),
                  const SizedBox(height: 24),
                  const Text(
                    'FLUTTER\nDOTA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      height: 0.95,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bienvenue, PGM.\nTous les héros. Un seul pick.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 18,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const _Stats(),
                  const SizedBox(height: 32),
                  const _Attributes(),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: _accent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                      // pushNamed looks up '/cards' in the routes map
                      // and pushes that page on top of this one.
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.cards),
                      icon: const Icon(Icons.play_arrow_rounded, size: 28),
                      label: const Text("ENTRER DANS L'ARÈNE"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Hero pictures across the top, faded into black.
class _HeroBackground extends StatelessWidget {
  const _HeroBackground();

  static const _heroes = ['juggernaut', 'lina', 'axe', 'crystal_maiden'];

  @override
  Widget build(BuildContext context) {
    // ShaderMask applies the gradient as transparency:
    // opaque at the top, fully transparent at mid-height.
    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white, Colors.transparent],
        stops: [0.0, 0.55],
      ).createShader(rect),
      blendMode: BlendMode.dstIn,
      child: Opacity(
        opacity: 0.35,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final hero in _heroes)
              Image.asset('assets/heroes/$hero.png', fit: BoxFit.cover),
          ],
        ),
      ),
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
        border: Border.all(color: WelcomeScreen._accent),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: WelcomeScreen._accent,
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
      children: [
        Expanded(
          child: _Stat(value: '20', label: 'HÉROS'),
        ),
        Expanded(
          child: _Stat(value: '4', label: 'ATTRIBUTS'),
        ),
        Expanded(
          child: _Stat(value: '1', label: 'LIGUE'),
        ),
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
          left: BorderSide(color: WelcomeScreen._accent, width: 3),
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

// The four attribute icons, with the same colors as the cards.
class _Attributes extends StatelessWidget {
  const _Attributes();

  @override
  Widget build(BuildContext context) {
    return Row(
      // spaceBetween spreads the four chips over the whole width.
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _Attribute(icon: 'str', label: 'FORCE', color: Colors.redAccent),
        _Attribute(icon: 'agi', label: 'AGILITÉ', color: Colors.greenAccent),
        _Attribute(icon: 'int', label: 'INTEL', color: Colors.lightBlueAccent),
        _Attribute(icon: 'poly', label: 'UNIVERSEL', color: Colors.amberAccent),
      ],
    );
  }
}

class _Attribute extends StatelessWidget {
  const _Attribute({
    required this.icon,
    required this.label,
    required this.color,
  });

  final String icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/attributes/$icon.png', width: 36, height: 36),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
