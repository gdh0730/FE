import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiniLineChart extends StatelessWidget {
  final List<double> values;

  const MiniLineChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.white,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.white,
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(values.length, (index) {
                return FlSpot(index.toDouble(), values[index]);
              }),
              isCurved: true,
              color: const Color(0xFF6B9723),
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 15,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const weekDays = ['월', '화', '수', '목', '금', '토', '일'];
                  String text = '';
                  if (value.toInt() >= 0 && value.toInt() < weekDays.length) {
                    text = weekDays[value.toInt()];
                  }
                  return Text(
                        text,
                        style: const TextStyle(fontSize: 10),
                        overflow: TextOverflow.clip,
                        softWrap: false,
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(enabled: false),
          minX: 0,
          maxX: 6,
          minY: values.reduce((a, b) => a < b ? a : b) - 10,
          maxY: values.reduce((a, b) => a > b ? a : b) + 10,
        ),
      ),
    );
  }
}