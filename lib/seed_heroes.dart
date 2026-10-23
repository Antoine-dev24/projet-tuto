import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet_tuto/firebase_options.dart';
import 'package:projet_tuto/presentation/repositories/firestore_dota_cards_repository.dart';
import 'package:projet_tuto/presentation/repositories/in_memory_dota_cards_repository.dart';

// One-shot entry point that copies the hard-coded heroes into Firestore.
// Firestore plugins need the Flutter engine, so it is not a "dart run"
// script but a second main, launched with:
//   flutter run -t lib/seed_heroes.dart
// It can be rerun safely: set() overwrites a document with the same id.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String message;
  try {
    final cards = await InMemoryDotaCardsRepository().getAll();
    final heroes = FirebaseFirestore.instance.collection('heroes');

    // A batch sends every write in a single request: all or nothing.
    final batch = FirebaseFirestore.instance.batch();
    for (final card in cards) {
      batch.set(heroes.doc(card.id), FirestoreDotaCardsRepository.toFirestore(card));
    }
    await batch.commit();

    message = '${cards.length} heroes written to Firestore.';
  } catch (e) {
    message = 'Seed failed: $e';
  }

  debugPrint(message);
  runApp(MaterialApp(home: Scaffold(body: Center(child: Text(message)))));
}
