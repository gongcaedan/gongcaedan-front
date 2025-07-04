import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/criminal_record_post_request.dart';

class CriminalRecordApi {
  static Future<void> submitCriminalRecords({
    required int candidateId,
    required List<CriminalRecordPostRequest> records,
  }) async {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/candidates/$candidateId/criminal-records');

    for (var record in records) {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(record.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('✅ 전과기록 등록 성공: ${response.body}');
      } else {
        print('❌ 전과기록 등록 실패 (${response.statusCode}): ${response.body}');
        throw Exception('전과기록 등록 실패');
      }
    }
  }
}
