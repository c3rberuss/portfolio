import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/modules/signup/controllers/signup_controller.dart';
import 'package:services/app/styles/palette.dart';
import 'package:services/app/widgets/input.dart';

class AccountInfoForm extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(
          controller: controller.email,
          label: "Email",
          labelColor: Palette.light,
          showClear: true,
          prefixIcon: Icon(LineIcons.user),
          focus: controller.focusEmail,
          nextFocus: controller.focusPassword,
          action: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16),
        Input(
          controller: controller.password,
          label: "Password",
          labelColor: Palette.light,
          isPassword: true,
          showClear: false,
          prefixIcon: Icon(LineIcons.key),
          focus: controller.focusPassword,
          nextFocus: controller.focusConfirmPassword,
          action: TextInputAction.next,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 16),
        Input(
          controller: controller.confirmPassword,
          label: "Confirm your password",
          labelColor: Palette.light,
          isPassword: true,
          showClear: false,
          prefixIcon: Icon(LineIcons.key),
          focus: controller.focusConfirmPassword,
          action: TextInputAction.done,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}
