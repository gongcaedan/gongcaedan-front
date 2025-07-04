import 'package:flutter/material.dart';
import 'package:gongcaedan_front/features/candidate/api/candidate_api.dart';
import 'package:gongcaedan_front/features/candidate/models/candidate_model.dart';
import 'package:gongcaedan_front/features/candidate/candidate_registration/candidate_registration.dart';

class CandidatePage extends StatefulWidget {
  final void Function(Candidate) onTapCandidate;

  const CandidatePage({super.key, required this.onTapCandidate});

  @override
  State<CandidatePage> createState() => _CandidatePageState();
}

class _CandidatePageState extends State<CandidatePage> {
  late Future<List<Candidate>> _candidateFuture;
  int _currentPage = 0;
  static const int _candidatesPerPage = 10;
  static const int _maxVisiblePages = 3;

  @override
  void initState() {
    super.initState();
    _candidateFuture = CandidateApi.fetchCandidates();
  }

  void _refreshCandidates() {
    setState(() {
      _candidateFuture = CandidateApi.fetchCandidates();
      _currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, -65),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CandidateRegistrationPage(),
              ),
            );

            if (result == true) {
              _refreshCandidates();
            }
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Candidate>>(
                future: _candidateFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('오류: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('후보자가 없습니다.'));
                  }

                  final candidates = snapshot.data!;
                  final totalPages = (candidates.length / _candidatesPerPage).ceil();
                  final pagedCandidates = candidates
                      .skip(_currentPage * _candidatesPerPage)
                      .take(_candidatesPerPage)
                      .toList();

                  int startPage = (_currentPage ~/ _maxVisiblePages) * _maxVisiblePages;
                  int endPage = (startPage + _maxVisiblePages).clamp(0, totalPages);

                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: pagedCandidates.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 21.0,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final candidate = pagedCandidates[index];
                            return GestureDetector(
                              onTap: () => widget.onTapCandidate(candidate),
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
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (startPage > 0)
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                setState(() => _currentPage = startPage - 1);
                              },
                            ),
                          ...List.generate(endPage - startPage, (i) {
                            final pageIndex = startPage + i;
                            return TextButton(
                              onPressed: () {
                                setState(() => _currentPage = pageIndex);
                              },
                              child: Text(
                                '${pageIndex + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: _currentPage == pageIndex
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            );
                          }),
                          if (endPage < totalPages)
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                setState(() => _currentPage = endPage);
                              },
                            ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
