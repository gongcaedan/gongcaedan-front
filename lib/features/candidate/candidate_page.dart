import 'package:flutter/material.dart';
import 'package:gongcaedan_front/features/candidate/api/candidate_api.dart';
import 'package:gongcaedan_front/features/candidate/models/candidate_model.dart';
import 'package:gongcaedan_front/features/candidate/candidate_registration/candidate_registration.dart';

class CandidatePage extends StatelessWidget {
  final VoidCallback onTapCandidate;

  const CandidatePage({super.key, required this.onTapCandidate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
              child: FutureBuilder<List<Candidate>>(
                future: CandidateApi.fetchCandidates(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('오류: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('후보자가 없습니다.'));
                  }

                  final candidates = snapshot.data!;
                  return GridView.builder(
                    itemCount: candidates.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 21.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final candidate = candidates[index];
                      return GestureDetector(
                        onTap: onTapCandidate,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.account_circle, size: 64, color: Colors.grey),
                              const SizedBox(height: 8),
                              Text(candidate.name, style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      );
                    },
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
