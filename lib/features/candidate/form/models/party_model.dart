class Party {
  final int id;
  final String name;
  final String logoUrl;
  final String description;

  Party({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.description,
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      id: json['id'],
      name: json['name'],
      logoUrl: json['logoUrl'],
      description: json['description'],
    );
  }
}
