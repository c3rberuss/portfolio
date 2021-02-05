import 'package:app/app/modules/addresses/views/addresses_view.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/views/services_view.dart';
import 'package:app/app/modules/orders/views/orders_view.dart';
import 'package:app/app/modules/profile/views/profile_view.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with Maintenance {
  ServicesView _servicesView;

  @override
  void initState() {
    super.initState();
    _servicesView = ServicesView();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Palette.white,
          body: PageView(
            controller: controller.pageController,
            onPageChanged: controller.toPage,
            children: [
              _servicesView,
              OrdersView(),
              AddressesView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: ObxValue(
            (page) {
              return SnakeNavigationBar.color(
                behaviour: SnakeBarBehaviour.pinned,
                snakeShape: SnakeShape.indicator,
                backgroundColor: Palette.dark,
                snakeViewColor: Palette.success,
                selectedItemColor: Palette.light,
                unselectedItemColor: Palette.grey,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                currentIndex: page.value,
                onTap: (page) {
                  inMaintenance().then((maintenance) {
                    if (maintenance) {
                      print(maintenance);
                      Get.offAllNamed(Routes.MAINTENANCE);
                    }
                  });
                  controller.toPage(page);
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Inicio'),
                  BottomNavigationBarItem(
                      icon: Icon(LineIcons.shopping_cart), label: 'Mis órdenes'),
                  BottomNavigationBarItem(icon: Icon(LineIcons.map_pin), label: 'Mis direcciones'),
                  BottomNavigationBarItem(icon: Icon(LineIcons.user), label: 'Mi perfil'),
                ],
              );
            },
            controller.page,
          ),
        );
      },
    );
  }
}
