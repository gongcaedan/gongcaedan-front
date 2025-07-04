class CareerPostRequest {
  final String position;
  final String organization;
  final String startDate;
  final String endDate;

  CareerPostRequest({
    required this.position,
    required this.organization,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'position': position,
        'organization': organization,
        'startDate': startDate,
        'endDate': endDate,
      };
}
