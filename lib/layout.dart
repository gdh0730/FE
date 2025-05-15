import 'package:flutter/material.dart';
import 'package:heal_lo/screens/calendar/calendar_screen.dart';
import 'package:heal_lo/screens/chatbot/chatbot_screen.dart';
import 'package:heal_lo/screens/home/home.dart';
import 'package:heal_lo/screens/my_page/mypage_screen.dart';
import 'package:heal_lo/screens/weekly_reports/weekly_summary_screen.dart';
import 'package:heal_lo/widgets/commons/bottom_navigation_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  static _MainLayoutState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainLayoutState>();

  @override
  State<MainLayout> createState() => _MainLayoutState();
}
class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 2;

  final List<Widget> _screens = [
    CalendarScreen(),
    ChatbotScreen(),
    HomeScreen(),
    WeeklySummaryScreen(),
    // MyPageScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CommonBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
      ),
    );
  }
}