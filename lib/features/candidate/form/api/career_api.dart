import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/career_post_request.dart';

class CareerApi {
  static Future<void> submitCareer({
    required int candidateId,
    required List<CareerPostRequest> careers,
  }) async {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/candidates/$candidateId/careers');

    for (var career in careers) {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(career.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ 경력 등록 성공: ${response.body}');
      } else {
        print('❌ 경력 등록 실패 (${response.statusCode}): ${response.body}');
        throw Exception('경력 등록 실패');
      }
    }
  }
}
