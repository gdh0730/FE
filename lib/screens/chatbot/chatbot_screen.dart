import 'package:flutter/material.dart';
import 'package:heal_lo/widgets/commons/app_bar.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
// Removed the unnecessary initState override.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWidget(),
      body: SafeArea(
        child: Center(
          child: const Text("추후 추가될 기능입니다."),
        ),
      ),
    );
  }
}