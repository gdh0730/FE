import 'package:flutter/material.dart';

class MedicationCheck extends StatelessWidget {
  final List<Map<String, dynamic>> medications;
  final void Function(int index, bool value) onCheckChanged;
  final void Function(int index) onDelete;

  const MedicationCheck({
    super.key,
    required this.medications,
    required this.onCheckChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (medications.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('기록이 없습니다.', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: medications.asMap().entries.map((entry) {
        int index = entry.key;
        var med = entry.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(med['name']),
                value: med['checked'],
                onChanged: (bool? value) {
                  onCheckChanged(index, value ?? false);
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color(0xFFCAE296),
                checkColor: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => onDelete(index),
            ),
          ],
        );
      }).toList(),
    );
  }
}