import 'package:flutter/material.dart';
import 'package:gongcaedan_front/features/candidate/models/candidate_model.dart';
import 'package:gongcaedan_front/features/candidate/api/candidate_detail_api.dart';
import 'package:gongcaedan_front/features/candidate/models/candidate_detail_model.dart';

class CandidateDetailPage extends StatefulWidget {
  final Candidate candidate;
  final VoidCallback onBack;

  const CandidateDetailPage({super.key, required this.candidate, required this.onBack});

  @override
  State<CandidateDetailPage> createState() => _CandidateDetailPageState();
}

class _CandidateDetailPageState extends State<CandidateDetailPage> {
  late Future<List<PledgeModel>> _pledgesFuture;
  late Future<List<CareerModel>> _careersFuture;
  late Future<List<EducationModel>> _educationsFuture;
  late Future<List<VideoModel>> _videosFuture;

  @override
  void initState() {
    super.initState();
    final id = widget.candidate.id;
    _pledgesFuture = CandidateDetailApi.fetchPledges(id);
    _careersFuture = CandidateDetailApi.fetchCareers(id);
    _educationsFuture = CandidateDetailApi.fetchEducations(id);
    _videosFuture = CandidateDetailApi.fetchVideos(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('후보자 정보'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        backgroundColor: Colors.grey.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 상단 프로필 영역
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: widget.candidate.profileImageUrl.isNotEmpty
                      ? Image.network(
                          widget.candidate.profileImageUrl,
                          width: 200,
                          height: 260,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 200,
                              height: 260,
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: const Icon(Icons.person, size: 100, color: Colors.black54),
                            );
                          },
                        )
                      : Container(
                          width: 150,
                          height: 200,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: const Icon(Icons.person, size: 100, color: Colors.black54),
                        ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.candidate.name,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text("[ 생년월일 ]", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(widget.candidate.birthDate ?? "정보 없음", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 6),
                      const Text("[ 소속정당 ]", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(widget.candidate.party?.name ?? "무소속", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 6),
                      FutureBuilder<List<EducationModel>>(
                        future: _educationsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("오류: ${snapshot.error}");
                          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("[ 학력 ]", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                ...snapshot.data!.map((edu) => Text(
                                      "${edu.schoolName} ${edu.major}",
                                      style: const TextStyle(fontSize: 16),
                                    )),
                              ],
                            );
                          }
                          return const Text("학력: 정보 없음", style: TextStyle(fontSize: 16));
                        },
                      ),

                      const SizedBox(height: 10),
                      IconButton(
                        icon: const Icon(Icons.emergency, color: Colors.red, size: 32),
                        onPressed: () {
                          // TODO: 전과기록 페이지 이동
                        },
                      )
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 24),

            // 공약 목록
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 200), // 👈 최소 높이 설정
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("📋 공약 목록", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 8),
                  FutureBuilder<List<PledgeModel>>(
                    future: _pledgesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("오류: ${snapshot.error}");
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data!
                              .where((p) => p.title.isNotEmpty)
                              .map((p) => Text("• ${p.title}", style: const TextStyle(fontSize: 16)))
                              .toList(),
                        );
                      }
                      return const Text("공약이 없습니다.");
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 하단 유튜브 영상 + 커리어
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 160,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("📹 유튜브 영상", style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Expanded(
                          child: FutureBuilder<List<VideoModel>>(
                            future: _videosFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text("오류: ${snapshot.error}");
                              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                return ListView(
                                  children: snapshot.data!
                                      .map((v) => ListTile(title: Text(v.title), subtitle: Text(v.videoUrl)))
                                      .toList(),
                                );
                              }
                              return const Text("영상 정보 없음");
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 160,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("💼 커리어", style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Expanded(
                          child: FutureBuilder<List<CareerModel>>(
                            future: _careersFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text("오류: ${snapshot.error}");
                              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                return ListView(
                                  children: snapshot.data!
                                      .map((c) => ListTile(title: Text(c.position), subtitle: Text(c.organization)))
                                      .toList(),
                                );
                              }
                              return const Text("커리어 없음");
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
