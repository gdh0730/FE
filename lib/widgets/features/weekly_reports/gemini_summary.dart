import 'package:flutter/material.dart';

class GeminiSummarySection extends StatelessWidget {
  final String summaryText;

  const GeminiSummarySection({
    super.key,
    required this.summaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gemini Summary",
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'BalooRegular',
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Text(
              summaryText.isNotEmpty
                  ? summaryText
                  : "이곳에 Gemini 데이터 요약 내용이 들어갑니다.\n예: 이번 주의 건강 지표는 매우 좋습니다.",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'PretendardLight',
                  color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}