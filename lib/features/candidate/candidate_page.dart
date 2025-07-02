import 'package:flutter/material.dart';
import 'package:gongcaedan_front/features/candidate/candidate_registration/candidate_registration.dart';

class CandidatePage extends StatelessWidget {
  final VoidCallback onTapCandidate;

  const CandidatePage({super.key, required this.onTapCandidate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // ✅ 플로팅 액션 버튼 추가
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CandidateRegistrationPage(),
            ),
            );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
       ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 21.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: onTapCandidate,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.person, size: 64, color: Colors.black),
                          SizedBox(height: 8),
                          Text('이름', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            const Text("1 2 3 4 5", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
