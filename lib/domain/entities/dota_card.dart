// Domain entity: pure Dart, no Flutter or infrastructure import.

import '../../dto/main_attribute.dart';

class DotaCardDto {
  const DotaCardDto({
    required this.id,
    required this.name,
    required this.picture,
    this.description,
    required this.mainAttribute,
  });

  final String id;
  final String name;
  final String picture;
  final String? description;
  final MainAttribute mainAttribute;
}




