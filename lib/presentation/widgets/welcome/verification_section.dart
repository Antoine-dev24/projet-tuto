import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/widgets/welcome/section.dart';

// Third section: how a submitted score gets checked.
// Text and checklist on the left, a sample "verified" submission on the right.
class VerificationSection extends StatelessWidget {
  const VerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);

    const intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          eyebrow: 'INTÉGRITÉ',
          title: 'Des scores vérifiés,\npas déclarés.',
          subtitle: "Un classement ne vaut que par ses résultats. Chaque "
              "score soumis passe par quatre contrôles avant d'apparaître "
              'au classement.',
        ),
        SizedBox(height: 36),
        _Check(
          icon: Icons.tag_rounded,
          title: 'Match ID obligatoire',
          text: "Chaque résultat est rattaché à l'identifiant officiel "
              'de la partie.',
        ),
        _Check(
          icon: Icons.fact_check_rounded,
          title: 'Contrôle automatique',
          text: 'Le score, les joueurs et la durée sont recoupés avec les '
              'données du match.',
        ),
        _Check(
          icon: Icons.handshake_rounded,
          title: 'Double validation',
          text: 'Les deux capitaines confirment le résultat avant sa '
              'publication.',
        ),
        _Check(
          icon: Icons.gavel_rounded,
          title: 'Arbitrage humain',
          text: 'En cas de litige, un arbitre de la ligue tranche sous 48 h.',
        ),
      ],
    );

    return WelcomeSection(
      color: WelcomeColors.surface,
      child: mobile
          ? const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [intro, SizedBox(height: 24), _SubmissionCard()],
            )
          : const Row(
              children: [
                // flex: the text gets 6 parts of the width, the card 5.
                Expanded(flex: 6, child: intro),
                SizedBox(width: 64),
                Expanded(flex: 5, child: _SubmissionCard()),
              ],
            ),
    );
  }
}

// One line of the checklist: icon in a square, title, explanation.
class _Check extends StatelessWidget {
  const _Check({required this.icon, required this.title, required this.text});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: WelcomeColors.accent.withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: WelcomeColors.accent, size: 20),
          ),
          const SizedBox(width: 16),
          // Expanded: the text wraps instead of overflowing on the right.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14,
                    height: 1.45,
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

// A fake score submission, showing every check passed.
class _SubmissionCard extends StatelessWidget {
  const _SubmissionCard();

  static const _header = TextStyle(
    color: Colors.white38,
    fontSize: 12,
    fontWeight: FontWeight.w800,
    letterSpacing: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WelcomeColors.background,
        border: Border.all(color: WelcomeColors.border),
        borderRadius: BorderRadius.circular(12),
        // A soft red glow around the card.
        boxShadow: [
          BoxShadow(
            color: WelcomeColors.accent.withValues(alpha: 0.18),
            blurRadius: 60,
            spreadRadius: -10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: WelcomeColors.border),
              ),
            ),
            child: const Row(
              children: [
                Text('SOUMISSION #4821', style: _header),
                Spacer(),
                Text('DIVISION 2', style: _header),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: _Team(
                        side: 'RADIANT',
                        name: 'LES ANCIENTS',
                        color: Color(0xFF92A525),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '2 – 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _Team(
                        side: 'DIRE',
                        name: 'ROSHAN GANG',
                        color: Color(0xFFC23C2A),
                        alignEnd: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.tag_rounded, color: Colors.white38, size: 16),
                      SizedBox(width: 8),
                      Text('MATCH ID', style: _header),
                      Spacer(),
                      Text(
                        '7824913562',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const _Status(label: 'Match ID reconnu', time: '14:02'),
                const _Status(label: 'Joueurs et durée recoupés', time: '14:02'),
                const _Status(label: 'Confirmé par les 2 capitaines', time: '14:31'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: WelcomeColors.verified.withValues(alpha: 0.1),
                    border: Border.all(
                      color: WelcomeColors.verified.withValues(alpha: 0.4),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: WelcomeColors.verified,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'SCORE VÉRIFIÉ',
                        style: TextStyle(
                          color: WelcomeColors.verified,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
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

class _Team extends StatelessWidget {
  const _Team({
    required this.side,
    required this.name,
    required this.color,
    this.alignEnd = false,
  });

  final String side;
  final String name;
  final Color color;
  // true for the team on the right: text aligned on the right edge.
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          side,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          textAlign: alignEnd ? TextAlign.end : TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

// One passed check: green tick, label, time.
class _Status extends StatelessWidget {
  const _Status({required this.label, required this.time});

  final String label;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: WelcomeColors.verified,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: WelcomeColors.background,
              size: 15,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 14,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
