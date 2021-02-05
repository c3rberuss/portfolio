import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/modules/services/controllers/services_controller.dart';
import 'package:services/app/modules/services/views/service_item_widget.dart';
import 'package:services/app/styles/palette.dart';
import 'package:services/app/utils/extensions.dart';

class ServicesView extends GetView<ServicesController> {
  final _x1 = 81.0;
  final _y1 = 0.0;
  final _x2 = 199.0;
  final _y2 = 1.0;

  @override
  Widget build(BuildContext context) {
    final List args = Get.arguments;

    return Scaffold(
      backgroundColor: Palette.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.white,
            leading: IconButton(
              icon: Icon(
                LineIcons.arrow_left,
                color: Palette.primary,
              ),
              onPressed: Get.back,
            ),
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final height = constraints.biggest.height;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedPositioned(
                      left: height.interpolate(_x1, 60, _x2, 16),
                      bottom: 64,
                      duration: Duration(milliseconds: 50),
                      child: AnimatedOpacity(
                        opacity: height.interpolate(_x1, _y1, _x2, _y2),
                        duration: Duration(milliseconds: 50),
                        child: Hero(
                          tag: args[0],
                          child: Text(
                            args[1],
                            style: context.textTheme.headline4.copyWith(
                              color: Palette.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      left: height.interpolate(_x1, 60, _x2, 16),
                      bottom: 10,
                      duration: Duration(milliseconds: 50),
                      child: Text(
                        "Services",
                        style: context.textTheme.headline5.copyWith(
                          color: Palette.grey,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            expandedHeight: 175,
            collapsedHeight: 57,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(LineIcons.search, color: Palette.primary, size: 24),
                onPressed: () {},
              )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  25,
                  (index) => ServiceItemWidget(
                    onPressed: () {},
                    onAdd: () {},
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
