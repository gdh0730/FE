import 'package:flutter/material.dart';
import 'package:heal_lo/widgets/features/emergency/emergency_button.dart';
import 'package:heal_lo/screens/my_page/emergency_contacts_model.dart';

class EmergencyContactsCard extends StatelessWidget {
  final EmergencyContact contact;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const EmergencyContactsCard({
    super.key,
    required this.contact,
    this.onEdit,
    this.onDelete,
  });

  void _showOptionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text("수정"),
                  onTap: () {
                    Navigator.pop(context);
                    // 수정 기능 구현
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("삭제"),
                  onTap: () {
                    Navigator.pop(context);
                    // 삭제 기능 구현
                  },
                ),
              ],
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    final is911 = contact.name == '119';
    return GestureDetector(
      onLongPress: is911 ? null : () => _showOptionsDialog(context),
      child: EmergencyButton(
        phoneNumber: contact.phoneNumber,
        text: contact.name,
        backgroundColor: contact.backgroundColor ?? const Color(0xFFFAEDCE),
        textColor: Colors.black,
        icon: const Icon(Icons.phone),
      ),
    );
  }
}