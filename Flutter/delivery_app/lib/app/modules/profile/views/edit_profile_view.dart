import 'package:app/app/modules/profile/controllers/profile_controller.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class EditProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.white,
            centerTitle: true,
            title: Text(
              "Editar perfil",
              style: TextStyle(color: Palette.dark),
            ),
            iconTheme: context.theme.iconTheme.copyWith(color: Palette.dark),
            pinned: true,
            leading: IconButton(
              icon: Icon(LineIcons.arrow_left),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: _UserForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserForm extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 50,
          backgroundColor: Palette.lightSecondary,
        ),
        Input(
          label: "Nombre",
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
          label: "Correo electrónico",
          controller: TextEditingController(),
          errorColor: Palette.dangerDark,
          //focus: controller.nameFocus,
          //nextFocus: controller.emailFocus,
          keyboardType: TextInputType.emailAddress,
          action: TextInputAction.next,
          validators: [
            //Validators.required,
          ],
        ),
        SizedBox(height: 16),
        Input(
          label: "Número de teléfono",
          controller: TextEditingController(),
          errorColor: Palette.dangerDark,
          //focus: controller.nameFocus,
          //nextFocus: controller.emailFocus,
          keyboardType: TextInputType.phone,
          action: TextInputAction.next,
          validators: [
            //Validators.required,
          ],
        ),
        SizedBox(height: 16),
        Input(
          label: "Contraseña",
          controller: TextEditingController(),
          errorColor: Palette.dangerDark,
          isPassword: true,
          showClear: false,
          //focus: controller.nameFocus,
          //nextFocus: controller.emailFocus,
          keyboardType: TextInputType.text,
          action: TextInputAction.done,
          validators: [
            //Validators.required,
          ],
        ),
        SizedBox(height: 45),
        CustomFillButton(
          text: "Guardar cambios",
          fullWidth: true,
          maxWidth: 500,
          minWidth: 500,
          buttonType: CustomButtonType.dark,
          onPressed: () {},
        ),
      ],
    );
  }
}
