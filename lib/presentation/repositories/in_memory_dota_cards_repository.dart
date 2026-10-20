import 'package:projet_tuto/domain/entities/dota_card.dart';
import 'package:projet_tuto/dto/main_attribute.dart';

import '../../domain/repositories/dota_cards_repository.dart';

// Adapter: a hard-coded implementation of the port.
// Pictures are local assets (declared in pubspec.yaml), downloaded from
// Valve's CDN and named after the hero's internal name
// (e.g. "antimage", "zuus" for Zeus).
class InMemoryDotaCardsRepository implements DotaCardsRepository {
  static const _heroesDir = 'assets/heroes';

  static String _picture(String slug) => '$_heroesDir/$slug.png';

  static final List<DotaCard> _cards = [
    // Strength
    DotaCard(id: 'axe', name: 'Axe', picture: _picture('axe'), mainAttribute: MainAttribute.strenght, description: 'Berserker\'s Call et Culling Blade.'),
    DotaCard(id: 'pudge', name: 'Pudge', picture: _picture('pudge'), mainAttribute: MainAttribute.strenght, description: 'Le boucher et son crochet.'),
    DotaCard(id: 'earthshaker', name: 'Earthshaker', picture: _picture('earthshaker'), mainAttribute: MainAttribute.strenght, description: 'Fissure et Echo Slam.'),
    DotaCard(id: 'tidehunter', name: 'Tidehunter', picture: _picture('tidehunter'), mainAttribute: MainAttribute.strenght, description: 'Ravage, le cauchemar des teamfights.'),
    DotaCard(id: 'sven', name: 'Sven', picture: _picture('sven'), mainAttribute: MainAttribute.strenght, description: 'God\'s Strength et Storm Hammer.'),
    // Agility
    DotaCard(id: 'antimage', name: 'Anti-Mage', picture: _picture('antimage'), mainAttribute: MainAttribute.agility, description: 'Brûle le mana, blink partout.'),
    DotaCard(id: 'juggernaut', name: 'Juggernaut', picture: _picture('juggernaut'), mainAttribute: MainAttribute.agility, description: 'Blade Fury et Omnislash.'),
    DotaCard(id: 'phantom_assassin', name: 'Phantom Assassin', picture: _picture('phantom_assassin'), mainAttribute: MainAttribute.agility, description: 'Coups critiques dévastateurs.'),
    DotaCard(id: 'drow_ranger', name: 'Drow Ranger', picture: _picture('drow_ranger'), mainAttribute: MainAttribute.agility, description: 'Flèches de givre à distance.'),
    DotaCard(id: 'sniper', name: 'Sniper', picture: _picture('sniper'), mainAttribute: MainAttribute.agility, description: 'Tire de très, très loin.'),
    // Intelligence
    DotaCard(id: 'crystal_maiden', name: 'Crystal Maiden', picture: _picture('crystal_maiden'), mainAttribute: MainAttribute.intelligence, description: 'Freezing Field et aura de mana.'),
    DotaCard(id: 'lina', name: 'Lina', picture: _picture('lina'), mainAttribute: MainAttribute.intelligence, description: 'Laguna Blade, pur burst magique.'),
    DotaCard(id: 'zeus', name: 'Zeus', picture: _picture('zuus'), mainAttribute: MainAttribute.intelligence, description: 'Thundergod\'s Wrath sur toute la map.'),
    DotaCard(id: 'lion', name: 'Lion', picture: _picture('lion'), mainAttribute: MainAttribute.intelligence, description: 'Hex, stun et Finger of Death.'),
    DotaCard(id: 'lich', name: 'Lich', picture: _picture('lich'), mainAttribute: MainAttribute.intelligence, description: 'Chain Frost qui rebondit.'),
    // Universal
    DotaCard(id: 'windranger', name: 'Windranger', picture: _picture('windrunner'), mainAttribute: MainAttribute.polyvalance, description: 'Shackleshot et Focus Fire.'),
    DotaCard(id: 'mirana', name: 'Mirana', picture: _picture('mirana'), mainAttribute: MainAttribute.polyvalance, description: 'Sacred Arrow et Moonlight Shadow.'),
    DotaCard(id: 'void_spirit', name: 'Void Spirit', picture: _picture('void_spirit'), mainAttribute: MainAttribute.polyvalance, description: 'Mobilité et dégâts magiques.'),
    DotaCard(id: 'pangolier', name: 'Pangolier', picture: _picture('pangolier'), mainAttribute: MainAttribute.polyvalance, description: 'Roule sur ses ennemis.'),
    DotaCard(id: 'marci', name: 'Marci', picture: _picture('marci'), mainAttribute: MainAttribute.polyvalance, description: 'Rebound et Unleash.'),
  ];

  @override
  Future<List<DotaCard>> getAll() async => List.unmodifiable(_cards);

  @override
  Future<DotaCard?> getById(String id) async {
    for (final card in _cards) {
      if (card.id == id) return card;
    }
    return null;
  }
}
