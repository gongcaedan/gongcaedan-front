import 'package:flutter/material.dart';
import 'package:gongcaedan_front/common/widgets/bottom_nav_bar.dart';
import 'package:gongcaedan_front/features/candidate/candidate_page.dart';
import 'package:gongcaedan_front/features/candidate/candidate_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _showCandidateDetail = false;

  Widget _buildBody() {
    if (_showCandidateDetail) {
      return CandidateDetailPage(
        onBack: () => setState(() => _showCandidateDetail = false),
      );
    }

    final List<Widget> _pages = [
      const Center(child: Text('홈')),
      CandidatePage(
        onTapCandidate: () => setState(() => _showCandidateDetail = true),
      ),
      const Center(child: Text('커뮤니티')),
      const Center(child: Text('내 정보')),
    ];

    return _pages[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _showCandidateDetail = false; // 탭 변경 시 상세 초기화
          });
        },
      ),
    );
  }
}
