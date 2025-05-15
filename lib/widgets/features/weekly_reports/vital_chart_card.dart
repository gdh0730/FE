import 'package:flutter/material.dart';
import 'package:heal_lo/widgets/features/weekly_reports/mini_line_chart.dart';

class VitalChartCard extends StatelessWidget {
  final String title;
  final List<double> values;

  const VitalChartCard({
    super.key,
    required this.title,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: MiniLineChart(values: values),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'PretendardSemibold',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}