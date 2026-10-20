import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tuto/cubits/dota_cards_cubit.dart';
import 'package:projet_tuto/domain/entities/dota_card.dart';
import 'package:projet_tuto/dto/main_attribute.dart';

// Grid of every hero card exposed by the DotaCardsCubit.
class DotaCards extends StatelessWidget {
  const DotaCards({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder rebuilds this part of the tree each time the cubit emits.
    return BlocBuilder<DotaCardsCubit, List<DotaCard>>(
      builder: (context, cards) {
        if (cards.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        // GridView.builder only builds the cells visible on screen.
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220, // column count adapts to screen width
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) => DotaCardTile(card: cards[index]),
        );
      },
    );
  }
}

class DotaCardTile extends StatelessWidget {
  const DotaCardTile({required this.card, super.key});

  final DotaCard card;

  @override
  Widget build(BuildContext context) {
    final color = _attributeColor(card.mainAttribute);

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
                Text(
                  card.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                // mainAxisSize.min: the Row only takes its content's width,
                // so the parent Column can center it.
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(card.mainAttribute.logo, width: 18, height: 18),
                    const SizedBox(width: 6),
                    Text(
                      card.mainAttribute.label.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                if (card.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    card.description!,
                    // Needed on top of the Column alignment: it centers
                    // each line when the text wraps over two lines.
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
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
