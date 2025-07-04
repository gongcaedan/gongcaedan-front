class VideoPostRequest {
  final String title;
  final String videoUrl;
  final String broadcastDate;

  VideoPostRequest({
    required this.title,
    required this.videoUrl,
    required this.broadcastDate,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'videoUrl': videoUrl,
        'broadcastDate': broadcastDate,
      };
}
