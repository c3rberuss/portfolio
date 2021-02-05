import 'package:app/app/modules/address/controllers/address_controller.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/input.dart';
import 'package:app/core/domain/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AddressView extends GetView<AddressController> {
  @override
  Widget build(BuildContext context) {
    final address = Get.arguments;
    controller.initialize(address);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.white,
            title: Text(
              "Completa la información",
              style: TextStyle(color: Palette.dark),
            ),
            iconTheme: context.theme.iconTheme.copyWith(color: Palette.dark),
            pinned: true,
            leading: IconButton(
              icon: Icon(LineIcons.arrow_left),
              onPressed: () {
                Get.back<Address>();
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: _AddressForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressForm extends GetView<AddressController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(
          label: "Dirección",
          controller: TextEditingController(text: controller.address.address),
          errorColor: Palette.dangerDark,
          //focus: controller.nameFocus,
          //nextFocus: controller.emailFocus,
          keyboardType: TextInputType.name,
          action: TextInputAction.next,
          validators: [
            //Validators.required,
          ],
        ),
        SizedBox(height: 16),
        Input(
          label: "# de casa, local o apartamento",
          controller: TextEditingController(),
          errorColor: Palette.dangerDark,
          //focus: controller.nameFocus,
          //nextFocus: controller.emailFocus,
          keyboardType: TextInputType.name,
          action: TextInputAction.next,
          validators: [
            //Validators.required,
          ],
        ),
        SizedBox(height: 16),
        Input(
          label: "Punto de referencia",
          controller: TextEditingController(),
          errorColor: Palette.dangerDark,
          //focus: controller.nameFocus,
          //nextFocus: controller.emailFocus,
          keyboardType: TextInputType.name,
          action: TextInputAction.next,
          validators: [
            //Validators.required,
          ],
        ),
        SizedBox(height: 16),
        Input(
          label: "Departamento",
          enabled: false,
          controller: TextEditingController(text: "San Miguel"),
          errorColor: Palette.dangerDark,
          //focus: controller.nameFocus,
          //nextFocus: controller.emailFocus,
          keyboardType: TextInputType.name,
          action: TextInputAction.next,
          validators: [
            //Validators.required,
          ],
        ),
        SizedBox(height: 16),
        Input(
          label: "Guardar dirección como:",
          controller: TextEditingController(),
          errorColor: Palette.dangerDark,
          //focus: controller.nameFocus,
          //nextFocus: controller.emailFocus,
          keyboardType: TextInputType.name,
          action: TextInputAction.next,
          validators: [
            //Validators.required,
          ],
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Establecer como predeterminada: ",
              style: TextStyle(fontSize: 12),
            ),
            Checkbox(
              value: true,
              onChanged: (isChecked) {},
              activeColor: Palette.dark,
            ),
          ],
        ),
        SizedBox(height: 16),
        CustomFillButton(
          text: "Guardar dirección",
          fullWidth: true,
          maxWidth: 500,
          minWidth: 500,
          buttonType: CustomButtonType.dark,
          onPressed: () {
            Get.back<Address>(result: controller.address);
          },
        ),
      ],
    );
  }
}
