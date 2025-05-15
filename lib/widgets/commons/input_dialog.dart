import 'package:flutter/material.dart';

class CommonInputDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final void Function(String) onSubmit;
  final String? initialText;

  const CommonInputDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.onSubmit,
    this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialText ?? '');

    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
        autofocus: true,
        maxLines: null,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.text.trim().isNotEmpty) {
              onSubmit(controller.text.trim());
              Navigator.pop(context);
            }
          },
          child: const Text('저장'),
        ),
      ],
    );
  }
}