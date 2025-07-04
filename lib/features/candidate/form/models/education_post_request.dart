class EducationPostRequest {
  final String schoolName;
  final String major;
  final String degree;
  final int graduationYear;

  EducationPostRequest({
    required this.schoolName,
    required this.major,
    required this.degree,
    required this.graduationYear,
  });

  Map<String, dynamic> toJson() => {
        'schoolName': schoolName,
        'major': major,
        'degree': degree,
        'graduationYear': graduationYear,
      };
}
