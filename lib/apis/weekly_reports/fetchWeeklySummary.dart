Future<Map<String, dynamic>> fetchWeeklySummaryData() async {
  await Future.delayed(const Duration(seconds: 1));

  // 더미데이터
  return {
    'score': 85,
    'percent': 0.85,
    'progress': 80,
    'summary': '',
  };

  // TODO: 실제 서버 연동 시 아래 코드 사용
  /*
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
  */
}