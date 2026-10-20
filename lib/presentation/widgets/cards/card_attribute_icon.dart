import 'package:flutter/material.dart';
import 'package:projet_tuto/dto/main_attribute.dart';

// Icon of a hero's main attribute (strength, agility...).
class CardAttributeIcon extends StatelessWidget {
  const CardAttributeIcon({required this.attribute, this.size = 21, super.key});

  final MainAttribute attribute;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(attribute.logo, width: size, height: size);
  }
}
