import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/widgets/welcome/section.dart';
import 'package:projet_tuto/routes.dart';

// Last section: one more call to action, then the footer.
class JoinSection extends StatelessWidget {
  const JoinSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);

    return WelcomeSection(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 24 : 64,
              vertical: mobile ? 40 : 64,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: WelcomeColors.accent.withValues(alpha: 0.5),
              ),
              // Red in the top left corner, fading into the dark surface.
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  WelcomeColors.accent.withValues(alpha: 0.25),
                  WelcomeColors.surface,
                ],
              ),
            ),
            child: Column(
              children: [
                Text(
                  "PRÊT À ENTRER\nDANS L'ARÈNE ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: mobile ? 34 : 48,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Inscription gratuite. Des coéquipiers à ton niveau. '
                  'Des résultats qui comptent vraiment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                WelcomeButton(
                  label: 'DÉCOUVRIR LES HÉROS',
                  icon: Icons.style_rounded,
                  onPressed: () => AppRoutes.go(context, AppRoutes.cards),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          Container(height: 1, color: WelcomeColors.border),
          const SizedBox(height: 24),
          // Logo on the left, legal line on the right
          // (one under the other when the screen is too narrow).
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 8,
              children: [
                const Text(
                  'FLUTTER DOTA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  '© 2026 · Ligue communautaire, non affiliée à Valve.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
