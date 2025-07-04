import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/education_post_request.dart';

class EducationApi {
  static Future<void> submitEducation({
    required int candidateId,
    required List<EducationPostRequest> educations,
  }) async {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/candidates/$candidateId/educations');

    for (var edu in educations) {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(edu.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('✅ 학력 등록 성공: ${response.body}');
      } else {
        print('❌ 학력 등록 실패 (${response.statusCode}): ${response.body}');
        throw Exception('학력 등록 실패');
      }
    }
  }
}
