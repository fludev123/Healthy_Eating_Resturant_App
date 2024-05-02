import 'package:flutter/material.dart';
import 'cart_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCartIcon;

  CustomAppBar({required this.title, this.showCartIcon = true});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.lightGreen,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: Image.asset(
              "images/logo.jpg",
              height: 50,
              width: 50,
            ),
          ),
          SizedBox(width: 8),
          Text(title),
        ],
      ),
      actions: [
        if (showCartIcon) CartIcon(),
      ],
    );
  }
}
