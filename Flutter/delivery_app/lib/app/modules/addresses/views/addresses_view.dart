import 'package:app/app/modules/addresses/views/address_item_view.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/core/domain/address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/addresses/controllers/addresses_controller.dart';
import 'package:line_icons/line_icons.dart';

class AddressesView extends GetView<AddressesController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: context.theme.iconTheme.copyWith(color: Palette.dark),
              backgroundColor: Palette.white,
              title: Text(
                'Mis Direcciones',
                style: TextStyle(color: Palette.dark),
              ),
              centerTitle: true,
              pinned: true,
              actions: [
                ObxValue<RxBool>(
                  (editing) {
                    if (editing.value) {
                      return IconButton(
                        icon: Icon(LineIcons.trash),
                        onPressed: () {},
                      );
                    }

                    return SizedBox();
                  },
                  controller.editing,
                )
              ],
            ),
            SliverToBoxAdapter(
              child: GetBuilder<AddressesController>(
                id: "address",
                builder: (_) {
                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return AddressItemView(
                        name: "Casa",
                        address:
                            "Col. Las palmeras, calle tritón, poligono 11, casa 18, San Miguel, San Miguel.",
                        ref: "Ref. Casa color verde",
                        selected: index == controller.indexSelected,
                        onTap: () {
                          controller.updateSelected(index);
                        },
                        onLongPress: () {
                          controller.selectAnimation(index);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        ObxValue<RxDouble>(
          (bottom) {
            return AnimatedPositioned(
              bottom: bottom.value,
              right: 16,
              duration: Duration(milliseconds: 200),
              child: FloatingActionButton(
                child: Icon(LineIcons.plus),
                backgroundColor: Palette.dark,
                onPressed: () async {
                  final result = await Get.toNamed(
                    Routes.LOCATION_PICKER,
                    arguments: _completeInfoAddress,
                  );
                },
              ),
            );
          },
          controller.bottomFAB,
        ),
        ObxValue<RxDouble>(
          (bottom) {
            return AnimatedPositioned(
              left: 16,
              right: 16,
              bottom: bottom.value,
              child: CustomFillButton(
                text: "Usar esta dirección como predeterminada",
                buttonType: CustomButtonType.dark,
                onPressed: () {
                  controller.useAsDefault();
                },
              ),
              duration: Duration(milliseconds: 200),
            );
          },
          controller.bottom,
        )
      ],
    );
  }

  Future<Address> _completeInfoAddress(String address) async {
    final result = await Get.toNamed(Routes.ADDRESS, arguments: address);
    return result;
  }
}
