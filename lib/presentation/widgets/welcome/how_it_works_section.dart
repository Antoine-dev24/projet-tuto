import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/widgets/welcome/section.dart';

// Second section: the three steps, from solo player to league matches.
class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const _steps = [
    _Step(
      number: '01',
      icon: Icons.person_add_alt_1_rounded,
      title: 'CRÉE TON PROFIL',
      text: 'Indique ton rang, tes positions préférées, ta région '
          'et tes disponibilités.',
    ),
    _Step(
      number: '02',
      icon: Icons.groups_rounded,
      title: 'TROUVE TON ÉQUIPE',
      text: 'La ligue te propose des joueurs de ton niveau qui cherchent '
          'exactement le rôle qui leur manque.',
    ),
    _Step(
      number: '03',
      icon: Icons.emoji_events_rounded,
      title: 'JOUE ET GRIMPE',
      text: 'Affronte les équipes de ta division. Chaque victoire validée '
          'te rapproche du sommet du classement.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);

    return WelcomeSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            eyebrow: 'COMMENT ÇA MARCHE',
            title: 'De joueur solo\nà équipe soudée.',
            subtitle: 'La ligue sert à une chose : te mettre en relation '
                'avec les bons joueurs, puis organiser des matchs qui '
                'comptent vraiment.',
          ),
          const SizedBox(height: 48),
          if (mobile)
            Column(
              children: [
                for (final step in _steps) ...[
                  step,
                  const SizedBox(height: 16),
                ],
              ],
            )
          else
            // IntrinsicHeight + stretch: the three cards get the height
            // of the tallest one, even if their texts differ.
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // .indexed gives (index, element) pairs.
                  for (final (index, step) in _steps.indexed) ...[
                    if (index > 0) const SizedBox(width: 20),
                    Expanded(child: step),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.number,
    required this.icon,
    required this.title,
    required this.text,
  });

  final String number;
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: WelcomeColors.surface,
        border: Border.all(color: WelcomeColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: WelcomeColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: WelcomeColors.accent, size: 26),
              ),
              // Spacer pushes the number to the right edge.
              const Spacer(),
              Text(
                number,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.12),
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
