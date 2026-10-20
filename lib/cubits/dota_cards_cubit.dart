import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tuto/cubits/dota_cards_state.dart';

import '../domain/repositories/dota_cards_repository.dart';

// The cubit only knows the port, not the concrete adapter:
// the repository is injected through the constructor.
class DotaCardsCubit extends Cubit<DotaCardsState> {
  DotaCardsCubit(this._repository) : super(const DotaCardsState());

  final DotaCardsRepository _repository;

  Future<void> load() async =>
      emit(state.copyWith(cards: await _repository.getAll()));

  // One method per mouse event: each call sets an explicit state,
  // so a missed event can't leave a card stuck zoomed (unlike a toggle).
  void hover(String id) => emit(state.copyWith(hoveredId: id));

  void unhover() => emit(DotaCardsState(cards: state.cards));
}
