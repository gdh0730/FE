import 'package:flutter/material.dart';

class SignOutBtn extends StatelessWidget {
  final VoidCallback onSignOut;

  const SignOutBtn({
    super.key,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: TextButton.icon(
          onPressed: () => _showSignOutDialog(context),
          icon: const Icon(
            Icons.logout,
            color: Colors.black26,
            size: 20,
          ),
          label: const Text(
            "로그아웃",
            style: TextStyle(
              fontFamily: 'PretendardExtraLight',
              fontSize: 16,
              color: Colors.black26,
              decoration: TextDecoration.underline,
                decorationColor: Colors.black26,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onSignOut();
            },
            child: const Text('확인', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}