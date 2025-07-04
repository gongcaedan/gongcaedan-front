class EducationModel {
  final String schoolName;
  final String major;
  final String degree;
  final int graduationYear;

  EducationModel({
    required this.schoolName,
    required this.major,
    required this.degree,
    required this.graduationYear,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      schoolName: json['schoolName'],
      major: json['major'],
      degree: json['degree'],
      graduationYear: json['graduationYear'],
    );
  }
}

class PledgeModel {
  final String title;
  final String description;
  final String category;

  PledgeModel({
    required this.title,
    required this.description,
    required this.category,
  });

  factory PledgeModel.fromJson(Map<String, dynamic> json) {
    return PledgeModel(
      title: json['title'],
      description: json['description'],
      category: json['category'],
    );
  }
}

class CareerModel {
  final String position;
  final String organization;
  final String startDate;
  final String endDate;

  CareerModel({
    required this.position,
    required this.organization,
    required this.startDate,
    required this.endDate,
  });

  factory CareerModel.fromJson(Map<String, dynamic> json) {
    return CareerModel(
      position: json['position'],
      organization: json['organization'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}

class VideoModel {
  final String title;
  final String videoUrl;
  final String broadcastDate;

  VideoModel({
    required this.title,
    required this.videoUrl,
    required this.broadcastDate,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'],
      videoUrl: json['videoUrl'],
      broadcastDate: json['broadcastDate'],
    );
  }
}
