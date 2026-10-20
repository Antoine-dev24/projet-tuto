import 'package:flutter/material.dart';

class CardAttributeLabel extends StatelessWidget {
  const CardAttributeLabel({required this.mainAttributeLabel, super.key});

  final String mainAttributeLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      mainAttributeLabel.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
    );
  }
}
