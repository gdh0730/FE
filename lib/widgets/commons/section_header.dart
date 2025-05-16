import 'package:flutter/material.dart';

class CommonSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAddPressed;

  const CommonSectionHeader({
    super.key,
    required this.title,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onAddPressed != null)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(const Color(0xFFCAE296)),
                foregroundColor: WidgetStateProperty.all(const Color(0xFF6B9723)),
                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                minimumSize: WidgetStateProperty.all(const Size(32, 32)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
              ),
              onPressed: onAddPressed,
              child: const Text("+"),
            ),
        ],
      ),
    );
  }
}