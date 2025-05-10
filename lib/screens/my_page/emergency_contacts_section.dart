import 'package:flutter/material.dart';
import 'package:heal_lo/widgets/commons/button.dart';
import 'package:heal_lo/widgets/features/emergency/emergency_contacts_card.dart';
import 'package:heal_lo/screens/my_page/emergency_contacts_model.dart';

class EmergencySection extends StatelessWidget {
  final List<EmergencyContact> contacts;
  final VoidCallback onAddContact;
  final void Function(EmergencyContact contact)? onEdit;
  final void Function(EmergencyContact contact)? onDelete;

  const EmergencySection({
    Key? key,
    required this.contacts,
    required this.onAddContact,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFE0E5B6),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            children: [
              const Text(
                "응급 연락처",
                style: TextStyle(
                  fontFamily: 'PretendardBlack',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              ...contacts.map((contact) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: EmergencyContactsCard(
                  contact: contact,
                  onEdit: () => onEdit?.call(contact),
                  onDelete: () => onDelete?.call(contact),
                ),
              )),
              if (contacts.length < 3) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: CommonButton(
                    onPressed: onAddContact,
                    text: "연락처 추가",
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}