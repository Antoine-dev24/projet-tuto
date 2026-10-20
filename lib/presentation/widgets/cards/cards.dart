import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tuto/cubits/dota_cards_cubit.dart';
import 'package:projet_tuto/cubits/dota_cards_state.dart';

import 'card.dart';

// Grid of every hero card exposed by the DotaCardsCubit.
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
          itemBuilder: (context, index) => DotaCard(card: cards[index]),
        );
      },
    );
  }
}
