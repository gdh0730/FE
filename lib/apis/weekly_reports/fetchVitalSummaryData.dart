Future<Map<String, List<double>>> fetchVitalSummaryData() async {

  // TODO: 실제 API 요청으로 변경하여야 합니다.
  // final response = await http.get(Uri.parse('https://your-api.com/api/vital-summary'));
  //
  // if (response.statusCode == 200) {
  //   final json = jsonDecode(response.body);
  //
  //   return {
  //     'bloodSugar': List<double>.from(json['bloodSugar']),
  //     'bloodPressure': List<double>.from(json['bloodPressure']),
  //     'heartRate': List<double>.from(json['heartRate']),
  //     'bodyTemperature': List<double>.from(json['bodyTemperature']),
  //   };
  // } else {
  //   throw Exception('Failed to load vital summary data');
  // }

  await Future.delayed(const Duration(seconds: 1));

  return {
    'bloodSugar': [100, 95, 110, 105, 120, 115, 98],
    'bloodPressure': [120, 122, 118, 117, 119, 121, 123],
    'heartRate': [72, 70, 74, 69, 75, 73, 71],
    'bodyTemperature': [36.5, 36.6, 36.4, 36.7, 36.5, 36.8, 36.6],
  };
}