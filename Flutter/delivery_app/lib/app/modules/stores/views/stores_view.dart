import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_list_item.dart';
import 'package:app/app/widgets/search_bar.dart';
import 'package:app/app/widgets/shopping_cart.dart';
import 'package:app/core/domain/resource.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:app/app/utils/extensions.dart' show Doubles;
import 'package:app/app/modules/stores/controllers/stores_controller.dart';
import 'package:line_icons/line_icons.dart';

class StoresView extends GetView<StoresController> {
  final _x1 = 83.92156907477228;
  final _y1 = 0.0;
  final _x2 = 224.0;
  final _y2 = 1.0;

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments['title'];
    controller.initialize(Get.arguments['serviceId']);

    return Scaffold(
      backgroundColor: Palette.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              controller.toggleBottomPosition();
              return true;
            },
            child: GetBuilder<StoresController>(
              id: "builder",
              builder: (_) {
                if (controller.status is Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.status is Success) {
                  return RefreshIndicator(
                    backgroundColor: Palette.dark,
                    child: CustomScrollView(
                      controller: controller.scrollController,
                      slivers: [
                        SliverAppBar(
                          backgroundColor: Palette.white,
                          leading: IconButton(
                            icon: Icon(LineIcons.arrow_left, color: Palette.dark),
                            onPressed: () => Get.back(),
                          ),
                          flexibleSpace: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) {
                              final height = constraints.biggest.height;

                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Positioned(
                                    top: 40,
                                    child: AnimatedOpacity(
                                      opacity: height.interpolate(_x1, _y1, _x2, _y2),
                                      duration: Duration(milliseconds: 50),
                                      child: SizedBox(
                                        width: Get.width,
                                        child: Text(
                                          "Delivery App",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 14,
                                    top: 30,
                                    child: ShoppingCart(count: 0),
                                  ),
                                  Positioned(
                                    left: 50,
                                    right: 50,
                                    bottom: 15,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: MarkdownBody(
                                        data: title,
                                        styleSheet: MarkdownStyleSheet(
                                          p: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    // child: Text(
                                    //   "$title",
                                    //   style: TextStyle(fontSize: 20),
                                    //   textAlign: TextAlign.center,
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    // ),
                                  ),
                                ],
                              );
                            },
                          ),
                          expandedHeight: 175,
                          collapsedHeight: 60,
                          pinned: true,
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(bottom: 32, top: 33),
                          sliver: SliverToBoxAdapter(
                            child: _StoresList(),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: ObxValue<RxBool>(
                            (isLoading) {
                              if (isLoading.value) {
                                return const Center(
                                  child: const Padding(
                                    padding: EdgeInsets.only(bottom: 40),
                                    child: const SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              }

                              return const SizedBox.shrink();
                            },
                            controller.isLoadingMore,
                          ),
                        ),
                      ],
                    ),
                    onRefresh: controller.refreshData,
                  );
                }

                return Center(
                  child: Text("No hay establecimientos que brinden este servicio :("),
                );
              },
            ),
          ),
          ObxValue<RxDouble>((bottom) {
            return AnimatedPositioned(
              bottom: bottom.value,
              left: 0,
              right: 0,
              duration: Duration(milliseconds: 200),
              child: SearchBar(onTap: () {}),
            );
          }, controller.bottom),
        ],
      ),
    );
  }
}

class _StoresList extends GetView<StoresController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoresController>(
      id: "data",
      builder: (_) {
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: controller.data.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomListItem(
              title: controller.data[index].site.name,
              imageUrl: controller.data[index].site.image,
              svg: true,
              multiLine: true,
              secondLine: AutoSizeText(
                controller.data[index].site.categories.join(", ").substring(0, 25),
                style: TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              thirdLine: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(LineIcons.map_marker, size: 20),
                  MarkdownBody(
                    data: "**${controller.data[index].site.distance.toStringAsFixed(2)} km**",
                  ),
                ],
              ),
              onTap: () {
                Get.toNamed(Routes.MENU);
              },
            );
          },
        );
      },
    );
  }
}
