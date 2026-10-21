import 'package:flutter/material.dart';

class CardDescription extends StatelessWidget {
  const CardDescription({
    required this.description,
    this.compact = false,
    super.key,
  });

  final String? description;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Text(
      description!,
      // Needed on top of the Column alignment: it centers
      // each line when the text wraps over two lines.
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      // Compact: height 1.0 tightens the line spacing (default is ~1.17).
      style: TextStyle(
        color: Colors.white70,
        fontSize: 12,
        height: compact ? 1.0 : null,
      ),
    );
  }
}
