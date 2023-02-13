import 'package:flutter/material.dart';

class HomeMenuItemWidget extends StatelessWidget {
  const HomeMenuItemWidget({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
    required this.itemColor,
  });

  final String title;
  final IconData? icon;
  final GestureTapCallback onTap;
  final Color itemColor;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 68.75,
    child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.only(top: 16, left: 16),
          tileColor: itemColor,
          leading: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color:  Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
  );
}
