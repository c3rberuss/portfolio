import 'dart:convert';

import 'package:app/app/modules/menu/views/pupusas_view.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:app/app/widgets/search_bar.dart';
import 'package:app/app/widgets/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/menu/controllers/menu_controller.dart';
import 'package:line_icons/line_icons.dart';

class MenuView extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (_) {
              controller.toggleBottomPosition();
              return true;
            },
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    icon: Icon(LineIcons.arrow_left, color: Palette.dark),
                    onPressed: Get.back,
                  ),
                  backgroundColor: Palette.white,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 40,
                            right: 75,
                            child: Container(
                              padding: EdgeInsets.only(left: 8, right: 8, top: 2),
                              decoration: Styles.boxDecoration(
                                background: Palette.success,
                                borderColor: Palette.dark.withOpacity(0.15),
                              ),
                              child: Text(
                                "Abierto",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Palette.light,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 14,
                            top: 30,
                            child: ShoppingCart(onTap: () {}, count: 0),
                          ),
                          ObxValue<RxDouble>((top) {
                            return AnimatedPositioned(
                              top: top.value,
                              left: 0,
                              right: 0,
                              child: AppBar(
                                backgroundColor: Palette.white,
                                iconTheme: context.theme.iconTheme.copyWith(color: Palette.dark),
                                leading: SizedBox(),
                                title: Text(
                                  "Pupuseria Maricela",
                                  style: TextStyle(
                                    color: Palette.dark,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                actions: [
                                  ShoppingCart(onTap: () {}, count: 0),
                                ],
                              ),
                              duration: Duration(milliseconds: 100),
                            );
                          }, controller.top),
                        ],
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: _StoreHeader(),
                ),
                _MenuCategory("Pupusas"),
                _MenuItems(),
                _MenuCategory("Bebidas"),
                _MenuItems(),
              ],
            ),
          ),
          ObxValue<RxDouble>(
            (bottom) {
              return AnimatedPositioned(
                bottom: bottom.value,
                child: SearchBar(
                  onTap: () {},
                ),
                duration: Duration(milliseconds: 200),
              );
            },
            controller.bottom,
          ),
        ],
      ),
    );
  }
}

class _StoreHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: Get.width,
      //color: Colors.grey,
      child: Column(
        children: [
          SizedBox(height: 16),
          SizedBox(
            width: 140,
            height: 100,
            child: Placeholder(),
          ),
          SizedBox(height: 32),
          Text(
            "Pupuseria Maricela",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "Dirección",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            width: 40,
            height: 12,
            child: Divider(
              height: 5,
              color: Palette.dark,
              thickness: 1,
            ),
          ),
          Text.rich(
            TextSpan(
              text: "Horario: ",
              children: [
                TextSpan(
                  text: "4:30 p.m. - 8:30 p.m.",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width * 0.7,
            child: Divider(
              color: Palette.dark,
              thickness: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final BorderSide _border = BorderSide(color: Palette.lightSecondary);
  final VoidCallback onTap;
  final String image;
  final String name;
  final double price;

  final String form = json.encode({
    "groups": [
      {
        "key": "masa",
        "title": "Masa",
        "subtotal": 0.0,
        "value": 1,
        "type": "single",
        "showHorizontal": true,
        "items": [
          {
            "label": "Maíz",
            "price": 0.0,
            "value": 1,
          },
          {
            "label": "Arroz",
            "price": 0.0,
            "value": 2,
          }
        ]
      }
    ],
  });

  _MenuItem({
    @required this.onTap,
    @required this.image,
    @required this.name,
    @required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.light,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Palette.grey.withOpacity(0.15),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
        border: Border(left: _border, right: _border, bottom: _border, top: _border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            showDialog(
              context: context,
              child: PupusasView(form: form),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 51,
                  width: 64,
                  child: Placeholder(),
                ),
                SizedBox(height: 16),
                Text(
                  this.name,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuCategory extends StatelessWidget {
  final String title;

  _MenuCategory(this.title);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 10),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 31, right: 31, bottom: 31),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 31,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
        children: [
          _MenuItem(
            image: "",
            price: 0.75,
            name: "Pupusa de queso",
            onTap: () {},
          ),
          _MenuItem(
            image: "",
            price: 1.00,
            name: "Pupusa de chicharrón",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
