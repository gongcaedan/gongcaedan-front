## lib 폴더 구조

| 폴더명         | 설명                                                                                                              |
| ----------- | --------------------------------------------------------------------------------------------------------------- |
| `common/`   | 앱 전반에서 **공통으로 사용되는 위젯, 테마, 상수, 스타일 등**을 정의하는 공간입니다. <br>예: `BottomNavBar`, `AppColors`, `Spacing`, `TextStyles` |
| `features/` | 각 기능별로 모듈화된 폴더로, 화면 구성 및 로직을 **도메인 단위로 분리**합니다. <br>예: `candidate`, `community`, `profile` 등의 페이지 관련 코드         |
| `utils/`    | 공통으로 사용하는 **유틸 함수, 포맷터, 헬퍼 클래스** 등을 정의하는 공간입니다. <br>예: 날짜 포맷, 문자열 처리 등                                          |

---

## 📦 features 모듈 구조 개요 (lib/features/ 기준)

| 폴더/파일명                       | 역할 설명                                                                                                       |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `api/`                       | 해당 도메인의 **서버 통신(API 요청)** 관련 기능을 담당합니다. <br>예: `GET`, `POST`, `PUT`, `DELETE` 요청 처리, `http` 사용 등            |
| `models/`                    | API 요청 또는 응답에서 사용되는 **데이터 모델 클래스 정의** 공간입니다. <br>예: `Candidate`, `Party` 등의 모델 정의 (`fromJson`, `toJson`) 포함 |

---

## 📱 HomePage 하단 탭 구조 안내 (`lib/home_page.dart`)

`HomePage`는 앱의 메인 뷰로, **하단 네비게이션 바(Bottom Navigation Bar)**를 기반으로 탭 전환이 이루어지는 구조입니다.  
각 탭에 해당하는 화면은 리스트 형태로 등록되어 있으며, 현재 선택된 인덱스에 따라 동적으로 화면이 렌더링됩니다.

---

### ✅ 탭 페이지 등록 구조

```dart
final List<Widget> _pages = [
  const Center(child: Text('홈')),
  CandidatePage(
    onTapCandidate: () => setState(() => _showCandidateDetail = true),
  ),
  const Center(child: Text('커뮤니티')),
  const Center(child: Text('내 정보')),
];

| 인덱스 | 탭 이름   | 위젯                   |
| --- | ------ | -------------------- |
| 0   | 홈      | `Text('홈')`          |
| 1   | 후보자 목록 | `CandidatePage(...)` |
| 2   | 커뮤니티   | `Text('커뮤니티')`       |
| 3   | 내 정보   | `Text('내 정보')`       |

---




