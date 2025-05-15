import 'package:flutter/material.dart';
import 'package:heal_lo/screens/my_page/emergency_contacts_model.dart';

class EditEmergencyContactSection extends StatefulWidget {
  final EmergencyContact contact;
  final void Function(EmergencyContact updatedContact) onSave;
  final VoidCallback onCancel;

  const EditEmergencyContactSection({
    super.key,
    required this.contact,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<EditEmergencyContactSection> createState() =>
      _EditEmergencyContactSectionState();
}

class _EditEmergencyContactSectionState extends State<EditEmergencyContactSection> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _phoneController = TextEditingController(text: widget.contact.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "연락처 수정",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: '이름',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: '전화번호',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                final updated = EmergencyContact(
                  name: _nameController.text.trim(),
                  phoneNumber: _phoneController.text.trim(),
                  backgroundColor: widget.contact.backgroundColor,
                );
                widget.onSave(updated);
              },
              child: const Text("저장"),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: widget.onCancel,
              child: const Text("취소"),
            ),
          ],
        ),
      ],
    );
  }
}