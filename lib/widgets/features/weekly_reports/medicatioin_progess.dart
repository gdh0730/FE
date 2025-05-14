import 'package:flutter/material.dart';

class MedicationProgressSection extends StatelessWidget {
  final int progress;
  const MedicationProgressSection ({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '투약 이행률',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'baloo2',
            ),
          ),
          const SizedBox(width: 8),
          Text(
          '${progress}%',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'baloo2',
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.medication_rounded,
            color: Color(0xFF6B9723),
            size: 30,
          ),
        ],
      ),
    );
  }
}