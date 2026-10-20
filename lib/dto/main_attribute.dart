enum MainAttribute {
  strenght(label: 'str', logo: 'assets/attributes/str.png'),
  agility(label: 'agi', logo: 'assets/attributes/agi.png'),
  intelligence(label: 'int', logo: 'assets/attributes/int.png'),
  polyvalance(label: 'poly', logo: 'assets/attributes/poly.png');

  const MainAttribute({
    required this.label,
    required this.logo
  });

  final String label;
  final String logo;
}

