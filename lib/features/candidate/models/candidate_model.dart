// lib/features/candidate/candidate_model.dart

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

class Candidate {
  final int id;
  final String name;
  final String profileImageUrl;
  final Party? party;

  Candidate({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    this.party,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      name: json['name'],
      profileImageUrl: json['profileImageUrl'] ?? '',
      party: json['party'] != null ? Party.fromJson(json['party']) : null,
    );
  }
}
