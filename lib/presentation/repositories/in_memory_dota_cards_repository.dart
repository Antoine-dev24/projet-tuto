import 'package:projet_tuto/domain/entities/dota_card.dart';
import 'package:projet_tuto/dto/main_attribute.dart';

import '../../domain/repositories/dota_cards_repository.dart';

// Adapter: a hard-coded implementation of the port.
// Pictures are local assets (declared in pubspec.yaml), downloaded from
// Valve's CDN and named after the hero's internal name
// (e.g. "antimage", "zeus" for Zeus).
class InMemoryDotaCardsRepository implements DotaCardsRepository {
  static const _heroesDir = 'assets/heroes';

  static String _picture(String slug) => '$_heroesDir/$slug.png';

  static final List<DotaCardDto> _cards = [
    // Strength
    DotaCardDto(id: 'axe', name: 'Axe', picture: _picture('axe'), mainAttribute: MainAttribute.strenght, description: 'Berserker\'s Call et Culling Blade.'),
    DotaCardDto(id: 'pudge', name: 'Pudge', picture: _picture('pudge'), mainAttribute: MainAttribute.strenght, description: 'Le boucher et son crochet.'),
    DotaCardDto(id: 'earthshaker', name: 'Earthshaker', picture: _picture('earthshaker'), mainAttribute: MainAttribute.strenght, description: 'Fissure et Echo Slam.'),
    DotaCardDto(id: 'tidehunter', name: 'Tidehunter', picture: _picture('tidehunter'), mainAttribute: MainAttribute.strenght, description: 'Ravage, le cauchemar des teamfights.'),
    DotaCardDto(id: 'sven', name: 'Sven', picture: _picture('sven'), mainAttribute: MainAttribute.strenght, description: 'God\'s Strength et Storm Hammer.'),
    // Agility
    DotaCardDto(id: 'antimage', name: 'Anti-Mage', picture: _picture('antimage'), mainAttribute: MainAttribute.agility, description: 'Brûle le mana, blink partout.'),
    DotaCardDto(id: 'juggernaut', name: 'Juggernaut', picture: _picture('juggernaut'), mainAttribute: MainAttribute.agility, description: 'Blade Fury et Omnislash.'),
    DotaCardDto(id: 'phantom_assassin', name: 'Phantom Assassin', picture: _picture('phantom_assassin'), mainAttribute: MainAttribute.agility, description: 'Coups critiques dévastateurs.'),
    DotaCardDto(id: 'drow_ranger', name: 'Drow Ranger', picture: _picture('drow_ranger'), mainAttribute: MainAttribute.agility, description: 'Flèches de givre à distance.'),
    DotaCardDto(id: 'sniper', name: 'Sniper', picture: _picture('sniper'), mainAttribute: MainAttribute.agility, description: 'Tire de très, très loin.'),
    // Intelligence
    DotaCardDto(id: 'crystal_maiden', name: 'Crystal Maiden', picture: _picture('crystal_maiden'), mainAttribute: MainAttribute.intelligence, description: 'Freezing Field et aura de mana.'),
    DotaCardDto(id: 'lina', name: 'Lina', picture: _picture('lina'), mainAttribute: MainAttribute.intelligence, description: 'Laguna Blade, pur burst magique.'),
    DotaCardDto(id: 'zeus', name: 'Zeus', picture: _picture('zeus'), mainAttribute: MainAttribute.intelligence, description: 'Thundergod\'s Wrath sur toute la map.'),
    DotaCardDto(id: 'lion', name: 'Lion', picture: _picture('lion'), mainAttribute: MainAttribute.intelligence, description: 'Hex, stun et Finger of Death.'),
    DotaCardDto(id: 'lich', name: 'Lich', picture: _picture('lich'), mainAttribute: MainAttribute.intelligence, description: 'Chain Frost qui rebondit.'),
    // Universal
    DotaCardDto(id: 'windranger', name: 'Windranger', picture: _picture('windrunner'), mainAttribute: MainAttribute.polyvalance, description: 'Shackleshot et Focus Fire.'),
    DotaCardDto(id: 'mirana', name: 'Mirana', picture: _picture('mirana'), mainAttribute: MainAttribute.polyvalance, description: 'Sacred Arrow et Moonlight Shadow.'),
    DotaCardDto(id: 'void_spirit', name: 'Void Spirit', picture: _picture('void_spirit'), mainAttribute: MainAttribute.polyvalance, description: 'Mobilité et dégâts magiques.'),
    DotaCardDto(id: 'pangolier', name: 'Pangolier', picture: _picture('pangolier'), mainAttribute: MainAttribute.polyvalance, description: 'Roule sur ses ennemis.'),
    DotaCardDto(id: 'marci', name: 'Marci', picture: _picture('marci'), mainAttribute: MainAttribute.polyvalance, description: 'Rebound et Unleash.'),
  ];

  @override
  Future<List<DotaCardDto>> getAll() async => List.unmodifiable(_cards);

  @override
  Future<DotaCardDto?> getById(String id) async {
    for (final card in _cards) {
      if (card.id == id) return card;
    }
    return null;
  }
}
