import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final String username;
  final String imageUrl;
  final VoidCallback onEditPressed;

  const UserProfileCard({
    super.key,
    required this.username,
    required this.imageUrl,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xFFFAEDCE),
      child: Center(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      username,
                      style: TextStyle(
                        fontFamily: 'PretendardSemibold',
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: onEditPressed,
                      tooltip: '프로필 수정',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}