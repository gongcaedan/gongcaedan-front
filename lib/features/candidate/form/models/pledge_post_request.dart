class PledgePostRequest {
  final String title;
  final String description;
  final String category;

  PledgePostRequest({
    required this.title,
    required this.description,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'category': category,
      };
}
