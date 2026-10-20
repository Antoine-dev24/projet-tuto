import 'package:flutter/material.dart';

class CardDescription extends StatelessWidget {
  const CardDescription({required this.description, super.key});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description!,
      // Needed on top of the Column alignment: it centers
      // each line when the text wraps over two lines.
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(color: Colors.white70, fontSize: 12),
    );
  }
}
