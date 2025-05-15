import 'package:flutter/material.dart';

class AiSummarySection extends StatelessWidget {
  final String summary;

  const AiSummarySection ({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 80),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            summary.isNotEmpty ? summary : '증상 및 감정 요약',
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'PretendardSemibold',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}