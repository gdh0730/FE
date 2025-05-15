import 'package:flutter/material.dart';
import 'package:heal_lo/apis/weekly_reports/fetchVitalSummaryData.dart';
import 'package:heal_lo/screens/weekly_reports/weekly_details_screen.dart';
import 'package:heal_lo/widgets/features/weekly_reports/vital_chart_card.dart';

class VitalChartsSection extends StatefulWidget {
  const VitalChartsSection({super.key});

  @override
  State<VitalChartsSection> createState() => _VitalChartsSectionState();
}

class _VitalChartsSectionState extends State<VitalChartsSection> {
  late Future<Map<String, List<double>>> _vitalDataFuture;

  @override
  void initState() {
    super.initState();
    _vitalDataFuture = fetchVitalSummaryData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '바이탈 레포트',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'PretendardSemibold',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WeeklyDetailsScreen()),
                  );
                },
                child: const Text(
                  '> more details',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF91937E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          FutureBuilder<Map<String, List<double>>>(
            future: _vitalDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                  children: List.generate(4, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
                );
              } else if (snapshot.hasError) {
                return const Text('데이터를 불러오는데 실패했습니다.');
              }

              final data = snapshot.data!;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
                children: [
                  VitalChartCard(
                    title: 'Blood Sugar',
                    values: data['bloodSugar'] ?? [],
                  ),
                  VitalChartCard(
                    title: 'Blood Pressure',
                    values: data['bloodPressure'] ?? [],
                  ),
                  VitalChartCard(
                    title: 'Heart Rate',
                    values: data['heartRate'] ?? [],
                  ),
                  VitalChartCard(
                    title: 'Body Temperature',
                    values: data['bodyTemperature'] ?? [],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}