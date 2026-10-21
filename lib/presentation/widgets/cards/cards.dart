import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tuto/cubits/dota_cards_cubit.dart';
import 'package:projet_tuto/cubits/dota_cards_state.dart';
import 'package:projet_tuto/domain/entities/dota_card.dart';
import 'package:projet_tuto/dto/main_attribute.dart';
import 'package:projet_tuto/presentation/widgets/cards/card_attribute_icon.dart';
import 'package:projet_tuto/presentation/widgets/cards/card_attribute_label.dart';

import 'card.dart';

// Hero cards grouped by main attribute: 4 side by side columns on wide
// screens, stacked sections on mobile.
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
        // LayoutBuilder gives the width actually available to this widget.
        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            // Same 4 sections in both layouts, only their container changes.
            // MainAttribute.values follows the declaration order:
            // strength, agility, intelligence, polyvalence.
            final columns = [
              for (final attribute in MainAttribute.values)
                _AttributeColumn(
                  attribute: attribute,
                  cards: cards
                      .where((card) => card.mainAttribute == attribute)
                      .toList(),
                  compact: isMobile,
                ),
            ];

            // A single scroll for the whole page: the sections move together.
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: isMobile
                  // Mobile: sections stacked, each one takes the full width.
                  // No Expanded here: the scroll view gives an infinite height.
                  ? Column(
                      children: [
                        for (final column in columns) ...[
                          column,
                          const SizedBox(height: 24),
                        ],
                      ],
                    )
                  : Row(
                      // Columns don't have the same number of heroes:
                      // align them on the top instead of centering them.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded gives each column a quarter of the width.
                        for (final column in columns) Expanded(child: column),
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}

// Header (icon + label) followed by the cards of one attribute.
class _AttributeColumn extends StatelessWidget {
  const _AttributeColumn({
    required this.attribute,
    required this.cards,
    required this.compact,
  });

  final MainAttribute attribute;
  final List<DotaCardDto> cards;
  // Passed down to the cards: tighter spacing on mobile.
  final bool compact;

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
              childAspectRatio: 1.05,
            ),
            itemCount: cards.length,
            itemBuilder: (context, index) =>
                DotaCard(card: cards[index], compact: compact),
          ),
        ],
      ),
    );
  }
}
