import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gongcaedan_front/features/candidate/models/candidate_detail_model.dart';

class CandidateDetailApi {
  static final String baseUrl = '${dotenv.env['API_BASE_URL']}/api/candidates';

  // 1. 학력
  static Future<List<EducationModel>> fetchEducations(int candidateId) async {
    final url = '$baseUrl/$candidateId/educations';
    print("🔍 [GET] $url");

    final response = await http.get(Uri.parse(url));
    print("📡 [응답 상태] ${response.statusCode}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print("🎓 [학력 응답] ${response.body}");
      return data.map((e) => EducationModel.fromJson(e)).toList();
    } else {
      print("❌ 학력 조회 실패: ${response.statusCode}");
      throw Exception("학력 조회 실패: ${response.statusCode}");
    }
  }

  // 2. 공약
  static Future<List<PledgeModel>> fetchPledges(int candidateId) async {
    final url = '$baseUrl/$candidateId/pledges';
    print("🔍 [GET] $url");

    final response = await http.get(Uri.parse(url));
    print("📡 [응답 상태] ${response.statusCode}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print("📜 [공약 응답] ${response.body}");
      return data.map((e) => PledgeModel.fromJson(e)).toList();
    } else {
      print("❌ 공약 조회 실패: ${response.statusCode}");
      throw Exception("공약 조회 실패: ${response.statusCode}");
    }
  }

  // 3. 커리어
  static Future<List<CareerModel>> fetchCareers(int candidateId) async {
    final url = '$baseUrl/$candidateId/careers';
    print("🔍 [GET] $url");

    final response = await http.get(Uri.parse(url));
    print("📡 [응답 상태] ${response.statusCode}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print("💼 [커리어 응답] ${response.body}");
      return data.map((e) => CareerModel.fromJson(e)).toList();
    } else {
      print("❌ 커리어 조회 실패: ${response.statusCode}");
      throw Exception("커리어 조회 실패: ${response.statusCode}");
    }
  }

  // 4. 유튜브 영상
  static Future<List<VideoModel>> fetchVideos(int candidateId) async {
    final url = '$baseUrl/$candidateId/debate-videos';
    print("🔍 [GET] $url");

    final response = await http.get(Uri.parse(url));
    print("📡 [응답 상태] ${response.statusCode}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print("🎥 [영상 응답] ${response.body}");
      return data.map((e) => VideoModel.fromJson(e)).toList();
    } else {
      print("❌ 영상 조회 실패: ${response.statusCode}");
      throw Exception("영상 조회 실패: ${response.statusCode}");
    }
  }
}
