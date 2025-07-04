import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/video_post_request.dart';

class VideoApi {
  static Future<void> submitVideo({
    required int candidateId,
    required VideoPostRequest video,
  }) async {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/candidates/$candidateId/debate-videos');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(video.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("✅ 영상 등록 성공: ${response.body}");
    } else {
      print("❌ 영상 등록 실패 (${response.statusCode}): ${response.body}");
      throw Exception("영상 등록 실패");
    }
  }
}
