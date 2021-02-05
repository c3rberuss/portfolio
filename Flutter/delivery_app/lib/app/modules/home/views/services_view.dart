import 'package:app/app/modules/home/controllers/services_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_list_item.dart';
import 'package:app/app/widgets/shopping_cart.dart';
import 'package:app/core/domain/resource.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/app/utils/extensions.dart' show Doubles;
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ServicesView extends StatelessWidget {
  final _x1 = 83.92156907477228;
  final _y1 = 0.0;
  final _x2 = 224.0;
  final _y2 = 1.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicesController>(
      id: "builder",
      builder: (controller) {
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
                            left: 0,
                            right: 0,
                            bottom: 11,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text.rich(
                                TextSpan(
                                  text: "Nuestros ",
                                  style: TextStyle(fontSize: 20),
                                  children: [
                                    TextSpan(
                                      text: "servicios",
                                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 14,
                            top: 32,
                            child: AnimatedOpacity(
                              opacity: height.interpolate(_x1, _y1, _x2, _y2),
                              duration: Duration(milliseconds: 50),
                              child: IconButton(
                                icon: Icon(LineIcons.home),
                                onPressed: () {
                                  //Get.offAllNamed(Routes.RESULT);
                                },
                              ),
                            ),
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
                    child: _ServicesList(),
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
          child: Text("No se ofrece ningún servicio por el momento :("),
        );
      },
    );
  }
}

class _ServicesList extends GetView<ServicesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicesController>(
      id: "data",
      builder: (_) {
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: controller.data.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomListItem(
              title: controller.data[index].name, // + " ${index + 1}",
              svg: true,
              imageUrl: controller.data[index].image,
              onTap: () {
                Get.toNamed(
                  Routes.STORES,
                  arguments: {
                    "title": controller.data[index].name,
                    "serviceId": controller.data[index].id,
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
