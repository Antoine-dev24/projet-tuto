import 'package:projet_tuto/domain/entities/dota_card.dart';

// Port (hexagonal architecture): the domain only declares what it needs.
// Adapters in the infrastructure layer (API, local DB, in-memory...)
// provide the actual implementation.
abstract interface class DotaCardsRepository {
  Future<List<DotaCardDto>> getAll();

  Future<DotaCardDto?> getById(String id);
}
