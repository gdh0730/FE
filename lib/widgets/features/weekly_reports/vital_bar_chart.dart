import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VitalBarChart extends StatelessWidget {
  final List<double> data;
  final String unit;

  const VitalBarChart({
    super.key,
    required this.data,
    required this.unit,
  });

  static const List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  List<BarChartGroupData> _buildBarChartData(List<double> values) {
    final double maxY = values.reduce((a, b) => a > b ? a : b) + 10;

    return List.generate(values.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: values[index],
            gradient: LinearGradient(
              colors: [Color(0xFFA5D060), Colors.green.shade800],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            width: 18,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY,
              color: Colors.grey[200],
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const double maxY = 140;

    return BarChart(
      BarChartData(
        maxY: maxY,
        barGroups: _buildBarChartData(data),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey[300],
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 10,
              getTitlesWidget: (value, _) => Text(
                '${value.toInt()}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, _) {
                final int index = value.toInt();
                if (index >= 0 && index < weekDays.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      weekDays[index],
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipPadding: const EdgeInsets.all(8),
            tooltipMargin: 8,
            tooltipBorder: BorderSide(color: Colors.grey.shade300),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toStringAsFixed(1)} $unit',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              );
            },
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}