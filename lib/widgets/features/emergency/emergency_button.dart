import 'package:flutter/material.dart';
import 'package:heal_lo/widgets/commons/button.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyButton extends StatelessWidget {
  final String phoneNumber;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;

  const EmergencyButton({
    super.key,
    required this.phoneNumber,
    required this.text,
    this.backgroundColor = const Color(0xFFFAEDCE),
    this.textColor = Colors.white,
    this.icon,
  });

  Future<void> _makePhoneCall(BuildContext context) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      // 전화 연결을 할 수 없는 경우 SnackBar로 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('전화 연결을 할 수 없습니다: $phoneNumber')),
      );}
  }

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
          width: 400,
          height: 50,
          child: CommonButton(
            onPressed: () => _makePhoneCall(context),
            text: text,
            type: ButtonType.elevated,
            icon: icon,
            backgroundColor: backgroundColor,
            textColor: textColor,
          )
      );
  }
}