import 'package:flutter/material.dart';
import 'package:heal_lo/widgets/commons/input_dialog.dart';
import 'package:heal_lo/widgets/commons/section_header.dart';

class VitalsSection extends StatefulWidget {
  final Map<String, String> initialVitals;

  const VitalsSection({
    super.key,
    required this.initialVitals
  });

  @override
  State<VitalsSection> createState() => _VitalsSectionState();
}

class _VitalsSectionState extends State<VitalsSection> {
  late Map<String, String> vitals;

  @override
  void initState() {
    super.initState();
    vitals = Map.from(widget.initialVitals);
  }

  void _showEditVitalsDialog() {
    final existingText = vitals.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');

    showDialog(
      context: context,
      builder: (context) => CommonInputDialog(
        title: 'Vital 항목 수정',
        hintText: '예: 혈압: 130/85',
        initialText: existingText,
        onSubmit: (text) {
          final lines = text
              .split('\n')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();

          final keys = vitals.keys.toList();
          final updatedVitals = <String, String>{};

          for (var line in lines) {
            final splitIndex = line.indexOf(':');
            if (splitIndex != -1) {
              final key = line.substring(0, splitIndex).trim();
              final value = line.substring(splitIndex + 1).trim();

              if (keys.contains(key)) {
                updatedVitals[key] = value;
              }
            }
          }

          // 입력 안 된 항목은 기존 값 유지
          for (var key in keys) {
            if (!updatedVitals.containsKey(key)) {
              updatedVitals[key] = vitals[key]!;
            }
          }
          setState(() {
            vitals = updatedVitals;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (vitals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('기록이 없습니다.', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 편집 버튼
        CommonSectionHeader(
          title: 'Vital Check',
          onAddPressed: _showEditVitalsDialog,
        ),
        // vitals 목록
        ...vitals.entries.map(
              (entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text('${entry.key}: ',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(entry.value)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}