import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/candidate_post_request.dart';

class CandidateApi {
  static Future<int> submitCandidate(CandidatePostRequest request) async {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/candidates');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ 후보자 등록 성공');
      print('📦 응답 데이터: $data');
      return data['id']; // ✅ 이걸 return 하려면 Future<int> 여야 함
    } else {
      throw Exception('❌ 후보자 등록 실패: ${response.statusCode}');
    }
  }
}
