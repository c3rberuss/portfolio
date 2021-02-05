import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ShoppingCart extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const ShoppingCart({this.count = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Badge(
        badgeColor: Palette.danger,
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(10),
        position: BadgePosition.topEnd(end: -12),
        padding: EdgeInsets.symmetric(horizontal: 5),
        badgeContent: Text(
          "$count",
          style: TextStyle(color: Palette.white, fontSize: 11),
        ),
        showBadge: count > 0,
        child: Icon(LineIcons.shopping_cart),
      ),
      onPressed: () => Get.toNamed(Routes.CART),
    );
  }
}
