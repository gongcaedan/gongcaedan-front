import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // ⬅️ 추가
import 'features/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();          // ✅ 비동기 전 초기화

  try {
    await dotenv.load(fileName: ".env");             // ✅ .env 파일 로드
    print("✅ .env loaded successfully");
    print("🔍 API_BASE_URL = ${dotenv.env['API_BASE_URL']}");
  } catch (e) {
    print("❌ Failed to load .env file: $e");         // ❗ 에러 메시지도 확인
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
