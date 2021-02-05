import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/qty_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_to_store_menu/json_to_store_menu.dart';

class PupusasView extends StatelessWidget {
  final String form;

  PupusasView({this.form});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: Styles.shapeRounded(),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 31, right: 31, top: 31, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Placeholder(),
            ),
            SizedBox(height: 16),
            Text("Pupusa de queso", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            Text(
              "Deliciosa pupusa de queso hecha en pupuseria Maricela",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            Text(
              "\$0.80",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Divider(
              color: Palette.dark,
              thickness: 0.5,
            ),
            JsonStoreMenuBuilder(
              form: form,
              activeColor: Palette.success,
              itemTitleBuilder: (title, price) {
                return Text(title);
              },
              groupTitleBuilder: (title) {
                return Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800));
              },
              onChanged: (result, subtotal) {},
              groupDescriptionBuilder: (description) {
                return Text(description);
              },
              dropdownBuilder: (items, selected, onChanged) {
                return DropdownButton(
                  items: items,
                  value: selected,
                  onChanged: onChanged,
                );
              },
              dropdownItemBuilder: (title, price) {
                return Text(title);
              },
            ),
            Divider(
              color: Palette.dark,
              thickness: 0.5,
            ),
            Text(
              "Cantidad",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            QtySelector(
              maxQty: 99,
              qtyChange: (int) {},
            ),
            SizedBox(height: 16),
            CustomFillButton(
              text: "Añadir a la order",
              fullWidth: true,
              minWidth: 500,
              maxWidth: 500,
              buttonType: CustomButtonType.success,
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
