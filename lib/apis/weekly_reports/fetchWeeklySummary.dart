/*Future<Map<String, dynamic>> fetchWeeklySummaryData() async {
  await Future.delayed(const Duration(seconds: 1));

  // 더미데이터
  return {
    'score': 85,
    'percent': 0.85,
    'progress': 80,
    'summary': '',
  };

  // TODO: 실제 서버 연동 시 아래 코드 사용
  
  final response = await http.get(Uri.parse('https://your-api.com/api/weekly-summary'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return {
      'score': json['score'],
      'percent': json['percent'],
      'progress': json['progress'],
    };
  } else {
    throw Exception('Failed to load weekly summary');
  }
  
}*/
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchWeeklySummary(String uid, String week) async {
  // Firestore 경로: users/{uid}/reports/{week}
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('reports')
      .doc(week)
      .get();

  final d = doc.data()!;  // 해당 문서가 존재한다고 가정 (weekly() 함수가 생성해줌)

  final score = d['score'] ?? 0;

  return {
    'score': score,                      // 점수 원값
    'percent': score / 100.0,            // 0.0 ~ 1.0 → 원형 퍼센트 바에 사용
    'progress': score,                   // 막대 그래프 등 raw 값 그대로
    'summary': d['summary'] ?? '',       // Gemini 요약
    'prediction': d['prediction'] ?? '', // 다음 주 예측 요약
    'pain': d['painAvg'],                // 평균 통증
    'temp': d['tempAvg'],                // 평균 체온
    'bp': d['bpAvg'],                    // 평균 혈압
    'sugar': d['sugarAvg'],              // 평균 혈당
  };
}
