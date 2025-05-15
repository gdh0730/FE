import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklySummaryHeader extends StatelessWidget {
  final String weekLabel;
  final int score;
  final double percent;

  const WeeklySummaryHeader({
    super.key,
    required this.weekLabel,
    required this.score,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFCAE296),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          const Text(
            "Weekly Report",
            style: TextStyle(
              fontFamily: 'PretendardBlack',
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weekLabel,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'PretendardSemibold',
                          color: Color(0xFF5F6E51),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Health Score",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'BalooRegular',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5F6E51),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          startDegreeOffset: -90,
                          centerSpaceRadius: 40,
                          centerSpaceColor: Colors.white,
                          sections: [
                            PieChartSectionData(
                              value: percent * 100,
                              color: Color(0xFFFFF092),
                              radius: 10,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              value: 100 - (percent * 100),
                              color: Color(0xFF474747),
                              radius: 10,
                              showTitle: false,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${(percent * 100).toInt()}',
                        style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'BalooRegular',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5F6E51),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}