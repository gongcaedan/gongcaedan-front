class CriminalRecordPostRequest {
  final String caseDetail;
  final String sentence;
  final String judgmentDate;

  CriminalRecordPostRequest({
    required this.caseDetail,
    required this.sentence,
    required this.judgmentDate,
  });

  Map<String, dynamic> toJson() => {
        'caseDetail': caseDetail,
        'sentence': sentence,
        'judgmentDate': judgmentDate,
      };
}
