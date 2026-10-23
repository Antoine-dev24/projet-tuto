import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_tuto/domain/entities/dota_card.dart';
import 'package:projet_tuto/dto/main_attribute.dart';

import '../../domain/repositories/dota_cards_repository.dart';

// Adapter: the same port as InMemoryDotaCardsRepository, backed by Firestore.
// Each hero is a document of the "heroes" collection, whose id is the
// hero's slug (e.g. "axe"), so getById is a direct document read.
class FirestoreDotaCardsRepository implements DotaCardsRepository {
  FirestoreDotaCardsRepository([FirebaseFirestore? firestore])
      : _heroes = (firestore ?? FirebaseFirestore.instance).collection('heroes');

  final CollectionReference<Map<String, dynamic>> _heroes;

  @override
  Future<List<DotaCardDto>> getAll() async {
    final snapshot = await _heroes.get();
    return snapshot.docs.map((doc) => _fromFirestore(doc.id, doc.data())).toList();
  }

  @override
  Future<DotaCardDto?> getById(String id) async {
    final doc = await _heroes.doc(id).get();
    final data = doc.data();
    // data() is null when no document has this id.
    return data == null ? null : _fromFirestore(doc.id, data);
  }

  // The enum is stored by its name ("agility"...), byName turns it back.
  static DotaCardDto _fromFirestore(String id, Map<String, dynamic> data) =>
      DotaCardDto(
        id: id,
        name: data['name'] as String,
        picture: data['picture'] as String,
        description: data['description'] as String?,
        mainAttribute: MainAttribute.values.byName(data['mainAttribute'] as String),
      );

  // Inverse of _fromFirestore, used by the seed script.
  // The id is not stored as a field: it is already the document id.
  static Map<String, dynamic> toFirestore(DotaCardDto card) => {
        'name': card.name,
        'picture': card.picture,
        'description': card.description,
        'mainAttribute': card.mainAttribute.name,
      };
}
