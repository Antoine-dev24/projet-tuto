import 'package:projet_tuto/domain/entities/dota_card.dart';

// Immutable screen state: a new instance is emitted on every change.
class DotaCardsState {
  const DotaCardsState({this.cards = const [], this.hoveredId});

  final List<DotaCardDto> cards;

  // Id of the card under the mouse, null when none is hovered.
  final String? hoveredId;

  // Copies the state, replacing only the given fields.
  // It cannot reset hoveredId to null ("null" means "keep the old value"),
  // which is why DotaCardsCubit.unhover() builds the state by hand.
  DotaCardsState copyWith({List<DotaCardDto>? cards, String? hoveredId}) =>
      DotaCardsState(
        cards: cards ?? this.cards,
        hoveredId: hoveredId ?? this.hoveredId,
      );
}
