import 'package:flutter/material.dart';
import 'package:heal_lo/apis/weekly_reports/fetchWeeklySummary.dart';
import 'package:heal_lo/widgets/commons/app_bar.dart';
import 'package:heal_lo/widgets/features/weekly_reports/ai_summary_section.dart';
import 'package:heal_lo/widgets/features/weekly_reports/medicatioin_progess.dart';
import 'package:heal_lo/widgets/features/weekly_reports/vital_charts_section.dart';
import 'package:heal_lo/widgets/features/weekly_reports/weekly_summary_header.dart';
import 'package:heal_lo/screens/weekly_reports/get_current_week_label.dart';

class WeeklySummaryScreen extends StatefulWidget {
  const WeeklySummaryScreen({super.key});

  @override
  State<WeeklySummaryScreen> createState() => _WeeklySummaryScreenState();
}

class _WeeklySummaryScreenState extends State<WeeklySummaryScreen> {
  late Future<Map<String, dynamic>> _weeklySummaryFuture;

  @override
  void initState() {
    super.initState();
    _weeklySummaryFuture = fetchWeeklySummaryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCAE296),
      appBar: CommonAppBarWidget(),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _weeklySummaryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WeeklySummaryHeader(
                    weekLabel: getCurrentWeekLabel(),
                    score: data['score'],
                    percent: data['percent'],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8.0,
                              spreadRadius: 2.0,
                              offset: Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                          child: Column(
                            children: [
                              const VitalChartsSection(),
                              const SizedBox(height: 20),
                              MedicationProgressSection(progress: data['progress']),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AiSummarySection(summary: data['summary'] ?? ''),                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}