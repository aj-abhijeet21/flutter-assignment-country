class Country {
  String code;
  String name;
  String native;
  String phone;
  String continent;
  String emoji;

  Country({
    required this.code,
    required this.continent,
    required this.emoji,
    required this.name,
    required this.native,
    required this.phone,
  });

  factory Country.fromJson(Map json) {
    return Country(
      code: json['code'],
      continent: json['continent']['name'],
      emoji: json['emoji'],
      name: json['name'],
      native: json['native'],
      phone: json['phone'],
    );
  }
}
