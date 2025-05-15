import 'package:flutter/material.dart';

class CommonBannerCard extends StatelessWidget implements PreferredSizeWidget {
  final String imagePath;
  final String? title;
  final VoidCallback onTap;
  final double height;
  final double? width;

  const CommonBannerCard({
    super.key,
    required this.imagePath,
    this.title,
    required this.onTap,
    this.height = 150,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: title != null
              ? Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title!,
                style: const TextStyle(
                  fontFamily: 'PretendardBold',
                  fontSize: 16,
                  color: Colors.white,
                  backgroundColor: Colors.black38,
                ),
              ),
            ),
          )
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}