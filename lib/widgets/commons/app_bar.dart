import 'package:flutter/material.dart';

class CommonAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CommonAppBarWidget({
    super.key,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFE8FFC2),
      toolbarHeight: 60,
      leadingWidth: 80,
      leading: showBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
              // 뒤로가기 버튼 클릭 시, 이전 화면으로 이동
              Navigator.pop(context);
            },
          ) : Padding(
        padding: const EdgeInsets.all(3.0),
        child: Image.asset(
          'assets/icons/mini_logo.png',
          width: 300,
          height: 300,
        ),
      ),
      title: Text(
        'HealLo',
        style: TextStyle(
          fontFamily: 'BalooRegular',
          fontSize: 30,
        )
      ),
    centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}