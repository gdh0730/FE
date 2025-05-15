// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class MedicationsApi {
//   static const String _baseUrl = 'https://your-api.com/medications';
//
//   // 복약 항목을 가져오는 API 요청
//   static Future<List<Map<String, dynamic>>> fetchMedications() async {
//     final response = await http.get(Uri.parse(_baseUrl));
//
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((item) => {'name': item['name'], 'checked': item['checked']}).toList();
//     } else {
//       throw Exception('Failed to load medications');
//     }
//   }
//
//   // 복약 항목을 추가하는 API 요청
//   static Future<void> addMedication(String medicationName) async {
//     final response = await http.post(
//       Uri.parse(_baseUrl),
//       body: json.encode({'name': medicationName}),
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to add medication');
//     }
//   }
//
//   // 복약 항목을 삭제하는 API 요청
//   static Future<void> deleteMedication(int id) async {
//     final response = await http.delete(
//       Uri.parse('$_baseUrl/$id'),
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete medication');
//     }
//   }
// }
Future<List<Map<String, dynamic>>> fetchMedications() async {
  // TODO: 실제 API 호출 코드
  await Future.delayed(const Duration(milliseconds: 500));

  return [
    {'name': '타이레놀 500mg', 'checked': false},
    {'name': '오메프라졸', 'checked': false},
  ];
}