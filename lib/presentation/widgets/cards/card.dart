import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tuto/cubits/dota_cards_cubit.dart';
import 'package:projet_tuto/cubits/dota_cards_state.dart';
import 'package:projet_tuto/domain/entities/dota_card.dart';
import 'package:projet_tuto/dto/main_attribute.dart';
import 'package:projet_tuto/presentation/widgets/cards/card_attribute_icon.dart';
import 'package:projet_tuto/presentation/widgets/cards/card_attribute_label.dart';
import 'package:projet_tuto/presentation/widgets/cards/card_description.dart';
import 'package:projet_tuto/presentation/widgets/cards/card_name.dart';

// One hero card: picture, name, main attribute and description,
// slightly zoomed while the mouse is over it.
class DotaCard extends StatelessWidget {
  const DotaCard({required this.card, super.key});

  final DotaCardDto card;

  @override
  Widget build(BuildContext context) {
    final color = _attributeColor(card.mainAttribute);

    // MouseRegion reports the mouse events to the cubit
    // (read, not watch: we are in a callback).
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => context.read<DotaCardsCubit>().hover(card.id),
      onExit: (_) => context.read<DotaCardsCubit>().unhover(),
      // BlocSelector only rebuilds when "is this card hovered?" changes,
      // so only the two cards involved rebuild when the mouse moves.
      child: BlocSelector<DotaCardsCubit, DotaCardsState, bool>(
        selector: (state) => state.hoveredId == card.id,
        builder: (context, isHovered) => AnimatedScale(
          scale: isHovered ? 1.07 : 1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: _buildCard(color),
        ),
      ),
    );
  }

  Widget _buildCard(Color color) {
    return Card(
      color: const Color(0xFF1B1E24),
      clipBehavior: Clip.antiAlias, // clips the image to the rounded corners
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Valve's hero pictures are 256x144, i.e. 16/9.
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              card.picture,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const Icon(Icons.broken_image, color: Colors.white54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              // Centers each Text horizontally inside the column.
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CardName(name: card.name),
                const SizedBox(height: 4),
                // mainAxisSize.min: the Row only takes its content's width,
                // so the parent Column can center it.
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CardAttributeIcon(attribute: card.mainAttribute),
                    const SizedBox(width: 6),
                    CardAttributeLabel(
                      mainAttributeLabel: card.mainAttribute.label,
                    ),
                  ],
                ),
                if (card.description != null) ...[
                  const SizedBox(height: 4),
                  CardDescription(description: card.description),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // A switch on an enum must be exhaustive: forgetting a value won't compile.
  static Color _attributeColor(MainAttribute attribute) => switch (attribute) {
    MainAttribute.strenght => Colors.redAccent,
    MainAttribute.agility => Colors.greenAccent,
    MainAttribute.intelligence => Colors.lightBlueAccent,
    MainAttribute.polyvalance => Colors.amberAccent,
  };
}
