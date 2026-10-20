import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tuto/cubits/dota_cards_cubit.dart';
import 'package:projet_tuto/cubits/dota_cards_state.dart';
import 'package:projet_tuto/domain/entities/dota_card.dart';
import 'package:projet_tuto/dto/main_attribute.dart';
import 'package:projet_tuto/presentation/widgets/cards/card_attribute_icon.dart';
import 'package:projet_tuto/presentation/widgets/cards/card_attribute_label.dart';

import 'card.dart';

// Hero cards split into 4 side by side columns, one per main attribute.
class DotaCards extends StatelessWidget {
  const DotaCards({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder rebuilds this part of the tree each time the cubit emits.
    return BlocBuilder<DotaCardsCubit, DotaCardsState>(
      // Hovering only changes hoveredId: no need to rebuild the whole grid.
      buildWhen: (previous, current) => previous.cards != current.cards,
      builder: (context, state) {
        final cards = state.cards;
        if (cards.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        // A single scroll for the whole page: the 4 columns move together.
        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Row(
            // Columns don't have the same number of heroes:
            // align them on the top instead of centering them.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MainAttribute.values follows the declaration order:
              // strength, agility, intelligence, polyvalence.
              for (final attribute in MainAttribute.values)
                // Expanded gives each column a quarter of the width.
                Expanded(
                  child: _AttributeColumn(
                    attribute: attribute,
                    cards: cards
                        .where((card) => card.mainAttribute == attribute)
                        .toList(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// Header (icon + label) followed by the cards of one attribute.
class _AttributeColumn extends StatelessWidget {
  const _AttributeColumn({required this.attribute, required this.cards});

  final MainAttribute attribute;
  final List<DotaCardDto> cards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardAttributeIcon(attribute: attribute, size: 28),
              const SizedBox(width: 8),
              CardAttributeLabel(mainAttributeLabel: attribute.label),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            // shrinkWrap: the grid takes its content's height
            // instead of asking for an infinite one inside the scroll view.
            shrinkWrap: true,
            // The SingleChildScrollView scrolls, not the grid itself.
            physics: const NeverScrollableScrollPhysics(),
            // Same delegate as before, so the cards keep their size.
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220, // column count adapts to the width
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: cards.length,
            itemBuilder: (context, index) => DotaCard(card: cards[index]),
          ),
        ],
      ),
    );
  }
}
