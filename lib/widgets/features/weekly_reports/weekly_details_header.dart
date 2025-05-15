import 'package:flutter/material.dart';
import 'package:heal_lo/apis/weekly_reports/fetchVitalSummaryData.dart';
import 'vital_bar_chart.dart';

class WeeklyDetailsHeader extends StatefulWidget {
  final TabController tabController;

  const WeeklyDetailsHeader({super.key, required this.tabController});

  @override
  State<WeeklyDetailsHeader> createState() => _WeeklyDetailsHeaderState();
}

class _WeeklyDetailsHeaderState extends State<WeeklyDetailsHeader> {
  Map<String, List<double>> _vitalData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabChange);
    _loadData();
  }

  void _handleTabChange() {
    if (widget.tabController.indexIsChanging) return;
    setState(() {}); // 탭 바뀔 때 UI 다시 그림
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    _vitalData = await fetchVitalSummaryData();
    setState(() => _isLoading = false);
  }

  Widget _buildChart() {
    final tabIndex = widget.tabController.index;

    if (_isLoading || _vitalData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    late final List<double> data;
    late final String unit;

    switch (tabIndex) {
      case 0:
        data = _vitalData['bloodSugar']!;
        unit = 'mg/dL';
        break;
      case 1:
        data = _vitalData['bloodPressure']!;
        unit = 'mmHg';
        break;
      case 2:
        data = _vitalData['heartRate']!;
        unit = 'bpm';
        break;
      case 3:
        data = _vitalData['bodyTemperature']!;
        unit = '℃';
        break;
      default:
        data = [];
        unit = '';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: VitalBarChart(data: data, unit: unit),
    );
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFFFF), Color(0xFFCAE296)],
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
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
              TabBar(
                controller: widget.tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(text: 'Bld Sugar'),
                  Tab(text: 'Bld Pressure'),
                  Tab(text: 'Hrt Rate'),
                  Tab(text: 'Temperature'),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildChart(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}