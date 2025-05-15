import 'package:flutter/material.dart';
import 'package:heal_lo/layout.dart';
import 'package:heal_lo/widgets/commons/app_bar.dart';
import 'package:heal_lo/widgets/commons/banner_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Home",
                    style: TextStyle(
                      fontFamily: 'PretendardBlack',
                      fontSize: 25,
                    ),
                  ),
                ),
                Center(
                  child: CommonBannerCard(
                    imagePath: 'assets/banners/title_banner.png',
                    height: 150,
                    onTap: () {
                      print("Banner Card Clicked");
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    CommonBannerCard(
                      imagePath: 'assets/banners/calendar_banner.png',
                      height: 100,
                      onTap: () {
                        MainLayout.of(context)?.changeTab(0);
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonBannerCard(
                      imagePath: 'assets/banners/chatbot_banner.png',
                      height: 100,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('알림'),
                              content: const Text('챗봇은 현재 개발 중인 기능입니다.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('확인'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonBannerCard(
                      imagePath: 'assets/banners/weekly_reports_banner.png',
                      height: 100,
                      onTap: () {
                        MainLayout.of(context)?.changeTab(3);
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonBannerCard(
                      imagePath: 'assets/banners/mypage_banner.png',
                      height: 100,
                      onTap: () {
                        MainLayout.of(context)?.changeTab(4);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40), // 마지막 여백
              ],
            ),
          ),
        ),
      ),
    );
  }
}