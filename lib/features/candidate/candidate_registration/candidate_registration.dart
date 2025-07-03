import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gongcaedan_front/common/widgets/count_selector.dart';
import 'package:gongcaedan_front/features/candidate/form/education_form.dart';
import 'package:gongcaedan_front/features/candidate/form/basic_info_form.dart';
import 'package:gongcaedan_front/features/candidate/form/career_form.dart';
import 'package:gongcaedan_front/features/candidate/form/criminal_record_form.dart';
import 'package:gongcaedan_front/features/candidate/form/pledge_form.dart';
import 'package:gongcaedan_front/features/candidate/form/video_form.dart';
import 'package:gongcaedan_front/features/candidate/form/models/party_model.dart';
import 'package:gongcaedan_front/features/candidate/form/models/candidate_post_request.dart';
import 'package:gongcaedan_front/features/candidate/form/api/candidate_api.dart';

enum RegistrationStep {
  basicInfo,
  education,
  career,
  criminal,
  pledge,
  videoLink,
}

class CandidateRegistrationPage extends StatefulWidget {
  const CandidateRegistrationPage({super.key});

  @override
  State<CandidateRegistrationPage> createState() => _CandidateRegistrationPageState();
}

class _CandidateRegistrationPageState extends State<CandidateRegistrationPage> {
  RegistrationStep _currentStep = RegistrationStep.basicInfo;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  String _name = '';
  String _birthDate = '';
  String _gender = 'M';
  int? _partyId;
  String _selectedParty = "";

  int _educationCount = 1;
  List<Map<String, dynamic>> _educationList = [
    {'school': '', 'major': '', 'degree': '', 'gradYear': ''}
  ];

  int _careerCount = 1;
  List<Map<String, dynamic>> _careerList = [
    {'position': '', 'organization': '', 'startDate': '', 'endDate': ''}
  ];

  int _criminalCount = 1;
  List<Map<String, dynamic>> _criminalList = [
    {'detail': '', 'sentence': '', 'judgmentDate': ''}
  ];

  int _pledgeCount = 1;
  List<Map<String, dynamic>> _pledgeList = [
    {'title': '', 'content': '', 'category': ''}
  ];

  Map<String, dynamic> _videoData = {
    'title': '',
    'url': '',
    'date': '',
  };

  void _goToNextStep() async {
    if (_currentStep == RegistrationStep.basicInfo) {
      if (_name.isEmpty || _birthDate.isEmpty || _partyId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이름, 생년월일, 정당을 입력해주세요.')),
        );
        return;
      }

      final request = CandidatePostRequest(
        name: _name,
        birthDate: _birthDate,
        gender: _gender,
        partyId: _partyId!,
        profileImageUrl: "http://example.com/kim.jpg", // TODO: 업로드 URL
      );

      try {
        await CandidateApi.submitCandidate(request);
        print("✅ 후보자 등록 성공");
      } catch (e) {
        print("❌ 후보자 등록 실패: $e");
      }
    }

    setState(() {
      final nextIndex = _currentStep.index + 1;
      if (nextIndex < RegistrationStep.values.length) {
        _currentStep = RegistrationStep.values[nextIndex];
      } else {
        print("✅ 모든 입력 완료");
      }
    });
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _stepTitle(_currentStep),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildStepContent(),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.grey.shade700,
                  ),
                  onPressed: _goToNextStep,
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _stepTitle(RegistrationStep step) {
    switch (step) {
      case RegistrationStep.basicInfo:
        return '후보자 기본정보 등록';
      case RegistrationStep.education:
        return '학력 등록';
      case RegistrationStep.career:
        return '경력 등록';
      case RegistrationStep.criminal:
        return '전과 기록 등록';
      case RegistrationStep.pledge:
        return '공약 등록';
      case RegistrationStep.videoLink:
        return '영상 링크 등록';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case RegistrationStep.basicInfo:
        return BasicInfoForm(
          onPartyChanged: (party) {
            setState(() {
              _partyId = party?.id;
              _selectedParty = party?.name ?? '';
            });
          },
          onPickImage: _pickImage,
          selectedImage: _selectedImage,
          onNameChanged: (val) => setState(() => _name = val),
          onBirthChanged: (val) => setState(() => _birthDate = val),
          onGenderChanged: (val) => setState(() => _gender = val),
        );
      case RegistrationStep.education:
        return _buildEducationStep();
      case RegistrationStep.career:
        return _buildCareerStep();
      case RegistrationStep.criminal:
        return _buildCriminalStep();
      case RegistrationStep.pledge:
        return _buildPledgeStep();
      case RegistrationStep.videoLink:
        return VideoForm(
          data: _videoData,
          onChanged: (field, value) {
            setState(() {
              _videoData[field] = value;
            });
          },
        );
    }
  }

  Widget _buildEducationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountSelector(
          label: "학력 갯수 선택",
          count: _educationCount,
          onIncrement: () {
            setState(() {
              _educationCount++;
              _educationList = List.generate(
                _educationCount,
                (_) => {'school': '', 'major': '', 'degree': '', 'gradYear': ''},
              );
            });
          },
        ),
        const SizedBox(height: 24),
        ...List.generate(_educationCount, (index) {
          final item = _educationList[index];
          return EducationForm(
            index: index,
            data: item,
            onChanged: (field, value) {
              setState(() {
                item[field] = value;
              });
            },
          );
        }),
      ],
    );
  }

  Widget _buildCareerStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountSelector(
          label: "경력 갯수 선택",
          count: _careerCount,
          onIncrement: () {
            setState(() {
              _careerCount++;
              _careerList = List.generate(
                _careerCount,
                (_) => {'position': '', 'organization': '', 'startDate': '', 'endDate': ''},
              );
            });
          },
        ),
        const SizedBox(height: 24),
        ...List.generate(_careerCount, (index) {
          final item = _careerList[index];
          return CareerForm(
            index: index,
            data: item,
            onChanged: (field, value) {
              setState(() {
                item[field] = value;
              });
            },
          );
        }),
      ],
    );
  }

  Widget _buildCriminalStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountSelector(
          label: "전과 갯수 선택",
          count: _criminalCount,
          onIncrement: () {
            setState(() {
              _criminalCount++;
              _criminalList = List.generate(
                _criminalCount,
                (_) => {'detail': '', 'sentence': '', 'judgmentDate': ''},
              );
            });
          },
        ),
        const SizedBox(height: 24),
        ...List.generate(_criminalCount, (index) {
          final item = _criminalList[index];
          return CriminalRecordForm(
            index: index,
            data: item,
            onChanged: (field, value) {
              setState(() {
                item[field] = value;
              });
            },
          );
        }),
      ],
    );
  }

  Widget _buildPledgeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountSelector(
          label: "공약 갯수 선택",
          count: _pledgeCount,
          onIncrement: () {
            setState(() {
              _pledgeCount++;
              _pledgeList = List.generate(
                _pledgeCount,
                (_) => {'title': '', 'content': '', 'category': ''},
              );
            });
          },
        ),
        const SizedBox(height: 24),
        ...List.generate(_pledgeCount, (index) {
          final item = _pledgeList[index];
          return PledgeForm(
            index: index,
            data: item,
            onChanged: (field, value) {
              setState(() {
                item[field] = value;
              });
            },
          );
        }),
      ],
    );
  }
}
