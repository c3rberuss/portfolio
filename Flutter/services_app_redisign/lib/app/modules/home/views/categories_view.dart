import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/modules/home/controllers/home_controller.dart';
import 'package:services/app/routes/app_pages.dart';
import 'package:services/app/styles/palette.dart';
import 'package:services/app/utils/extensions.dart' show Inter;

class CategoriesView extends GetView<HomeController> {
  final TextTheme textTheme;
  final _x1 = 83.92156907477228;
  final _y1 = 0.0;
  final _x2 = 224.0;
  final _y2 = 1.0;

  CategoriesView(this.textTheme);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Palette.white,
          elevation: 0,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final height = constraints.biggest.height;

              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    left: 16,
                    bottom: 64,
                    child: AnimatedOpacity(
                      opacity: height.interpolate(_x1, _y1, _x2, _y2),
                      duration: Duration(milliseconds: 50),
                      child: Text(
                        "Hello, Josué",
                        style: textTheme.headline3.copyWith(
                          color: Palette.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 8,
                    child: Text(
                      "Categories",
                      style: textTheme.headline5.copyWith(
                        color: Palette.grey,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          expandedHeight: 200,
          collapsedHeight: 60,
          pinned: true,
          actions: [
            IconButton(
              icon: Icon(LineIcons.search, color: Palette.primary, size: 24),
              onPressed: () {},
            )
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 16, bottom: 32, right: 16, top: 32),
          sliver: SliverGrid.count(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: List.generate(
              30,
              (index) => CategoryItemWidget(
                id: index,
                onPressed: () {
                  Get.toNamed(Routes.SERVICES, arguments: [index, "Category Name"]);
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final int id;

  CategoryItemWidget({@required this.onPressed, this.id});

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/icons/settings.png",
                  ),
                ),
                SizedBox(height: 16),
                Hero(
                  tag: id,
                  flightShuttleBuilder: _flightShuttleBuilder,
                  child: AutoSizeText(
                    "Category Name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Palette.primary.withOpacity(0.05),
            offset: Offset(0, 15),
          ),
        ],
      ),
    );
  }
}
