import 'package:flutter/material.dart';

class CandidateDetailPage extends StatelessWidget {
  final VoidCallback onBack;

  const CandidateDetailPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView( // ✅ 높이 초과 대비 스크롤 허용
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // 🔙 Back 버튼
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBack,
                    iconSize: 28,
                  ),
                ),
                const SizedBox(height: 16),

                // 🧱 상단 프로필 영역
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ 이미지 더 크게
                    Container(
                      width: 200,
                      height: 260,
                      color: Colors.white,
                      child: const Icon(Icons.person, size: 120, color: Colors.black54),
                    ),
                    const SizedBox(width: 24),

                    // 텍스트 정보 + 경고 아이콘
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("이재명", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          const Text("생년월일: 1964.12.22", style: TextStyle(fontSize: 18)),
                          const Text("소속정당: 더불어민주당", style: TextStyle(fontSize: 18)),
                          const Text("학력: 중앙대학교 법학과", style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 20),
                          const Icon(Icons.emergency, color: Colors.red, size: 32),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 📋 공약 목록
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: const Text("*공약 (제목만 나열)", style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 24),

                // 📹 유튜브 영상 + 커리어
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 140,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: const Text("유튜브 영상", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 140,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: const Text("커리어", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
