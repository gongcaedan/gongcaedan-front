class CandidatePostRequest {
  final String name;
  final String birthDate;
  final String gender;
  final int partyId;
  final String profileImageUrl;

  CandidatePostRequest({
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.partyId,
    required this.profileImageUrl,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "birthDate": birthDate,
        "gender": gender,
        "party": {"id": partyId},
        "profileImageUrl": profileImageUrl,
      };
}
