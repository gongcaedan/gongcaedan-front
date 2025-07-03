import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/party_model.dart';

class PartyApi {
  static Future<List<Party>> fetchParties() async {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/parties');

    final response = await http.get(url);
    final decoded = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(decoded);
      return jsonList.map((e) => Party.fromJson(e)).toList();
    } else {
      throw Exception('정당 목록 불러오기 실패: ${response.statusCode}');
    }
  }
}
