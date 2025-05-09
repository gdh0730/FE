import 'package:flutter/material.dart';
import 'package:heal_lo/screens/home/home.dart';
import 'package:heal_lo/widgets/commons/bottom_navigation_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}
class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 2;

  final List<Widget> _screens = [
    // CalendarScreen(),
    // ChatBotScreen(),
    HomeScreen(),
    // MyPageScreen(),
    // ReportScreen(),
  ];

  void _onTabTapped(int index) {
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