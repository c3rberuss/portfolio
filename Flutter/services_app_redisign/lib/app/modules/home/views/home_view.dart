import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/modules/cart/views/cart_view.dart';
import 'package:services/app/modules/home/controllers/home_controller.dart';
import 'package:services/app/modules/home/views/categories_view.dart';
import 'package:services/app/modules/profile/views/profile_view.dart';
import 'package:services/app/styles/palette.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          backgroundColor: Palette.white,
          body: PageView(
            controller: controller.pageController,
            onPageChanged: controller.goToPage,
            children: <Widget>[
              CategoriesView(context.textTheme),
              CartView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.pinned,
            snakeShape: SnakeShape.indicator,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: Palette.lightSecondary),
            ),
            //padding: EdgeInsets.all(8),

            ///configuration for SnakeNavigationBar.color
            snakeViewColor: Palette.primary,
            selectedItemColor: Palette.primary,
            unselectedItemColor: Palette.primaryDark.withOpacity(0.6),
            backgroundColor: Palette.white,

            ///configuration for SnakeNavigationBar.gradient
            // snakeViewGradient: selectedGradient,
            // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
            // unselectedItemGradient: unselectedGradient,

            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: controller.currentPage.value,
            onTap: (index) {
              controller.goToPage(index);
              controller.pageController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: IconBadge(
                    badgeColor: Palette.danger,
                    top: 0,
                    right: 0,
                    icon: Icon(LineIcons.shopping_cart),
                  ),
                  label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(LineIcons.user), label: 'Account'),
            ],
          ),
        );
      },
    );
  }
}
