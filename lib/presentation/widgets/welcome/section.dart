import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/widgets/app_bar.dart';

// Colors shared by every section of the welcome page.
class WelcomeColors {
  // Private constructor: this class only holds constants, no instances.
  WelcomeColors._();

  static const accent = Color(0xFFE5322D); // Dota red
  static const verified = Color(0xFF3DDC84); // "checked" green
  static const background = Color(0xFF050607); // almost black
  static const surface = Color(0xFF0E1116); // a bit lighter, for bands/cards
  static const border = Color(0xFF2A2E36);
}

// Same breakpoint as the top bar: below it, columns get stacked.
bool isMobileWidth(BuildContext context) =>
    MediaQuery.sizeOf(context).width < mobileBreakpoint;

// A full-width band of the page: its background goes edge to edge,
// its content stays centered and never wider than maxWidth.
class WelcomeSection extends StatelessWidget {
  const WelcomeSection({
    required this.child,
    this.color,
    this.verticalPadding,
    super.key,
  });

  static const maxWidth = 1100.0;

  final Widget child;
  final Color? color;
  // null: default spacing, depending on the screen width.
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    final vertical = verticalPadding ?? (isMobileWidth(context) ? 56 : 96);

    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: vertical),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          // width: infinity = "as wide as allowed", so the content
          // starts on the left edge of the 1100px column.
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

// Small red label + big title + optional paragraph, at the top of a section.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    required this.eyebrow,
    required this.title,
    this.subtitle,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileWidth(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // min: the Row only takes the width of its children.
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 24, height: 2, color: WelcomeColors.accent),
            const SizedBox(width: 10),
            Text(
              eyebrow,
              style: const TextStyle(
                color: WelcomeColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: mobile ? 32 : 44,
            height: 1.05,
            fontWeight: FontWeight.w900,
          ),
        ),
        // "if" inside a list: the widgets are only added when subtitle exists.
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              subtitle!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// Big call-to-action button: filled red, or outlined white.
class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.outlined = false,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool outlined;

  static const _padding = EdgeInsets.symmetric(horizontal: 28, vertical: 20);
  static const _textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    letterSpacing: 2,
  );

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));

    if (outlined) {
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white38),
          shape: shape,
          padding: _padding,
          textStyle: _textStyle,
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 22),
        label: Text(label),
      );
    }
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: WelcomeColors.accent,
        foregroundColor: Colors.white,
        shape: shape,
        padding: _padding,
        textStyle: _textStyle,
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      label: Text(label),
    );
  }
}
