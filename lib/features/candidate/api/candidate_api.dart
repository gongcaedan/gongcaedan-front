import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/candidate_model.dart';

class CandidateApi {
  static Future<List<Candidate>> fetchCandidates() async {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/candidates');

    final response = await http.get(url);

    print('📥 요청 URL: $url');
    print('📦 응답 상태 코드: ${response.statusCode}');

    // 👇 UTF-8로 명시적으로 디코딩
    final decodedBody = utf8.decode(response.bodyBytes);
    print('🧾 응답 바디:\n$decodedBody');

    if (response.statusCode == 200) {
      final List data = json.decode(decodedBody);
      return data.map((e) => Candidate.fromJson(e)).toList();
    } else {
      throw Exception('후보자 목록 불러오기 실패: ${response.statusCode}');
    }
  }
}
