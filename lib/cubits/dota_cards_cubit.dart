import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tuto/domain/entities/dota_card.dart';

import '../domain/repositories/dota_cards_repository.dart';

// The cubit only knows the port, not the concrete adapter:
// the repository is injected through the constructor.
class DotaCardsCubit extends Cubit<List<DotaCard>> {
  DotaCardsCubit(this._repository) : super(const []); // initial state: empty

  final DotaCardsRepository _repository;

  Future<void> load() async => emit(await _repository.getAll());
}
