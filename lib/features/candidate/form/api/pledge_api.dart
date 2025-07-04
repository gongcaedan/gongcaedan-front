import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/pledge_post_request.dart';

class PledgeApi {
  static Future<void> submitPledges({
    required int candidateId,
    required List<PledgePostRequest> pledges,
  }) async {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/candidates/$candidateId/pledges');

    for (var pledge in pledges) {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(pledge.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("✅ 공약 등록 성공: ${response.body}");
      } else {
        print("❌ 공약 등록 실패 (${response.statusCode}): ${response.body}");
        throw Exception("공약 등록 실패");
      }
    }
  }
}
