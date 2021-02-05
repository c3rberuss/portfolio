import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/modules/signup/controllers/signup_controller.dart';
import 'package:services/app/styles/palette.dart';
import 'package:services/app/widgets/input.dart';

class PersonalInfoForm extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(
          controller: controller.name,
          label: "Name",
          labelColor: Palette.light,
          showClear: true,
          prefixIcon: Icon(LineIcons.user),
          focus: controller.focusName,
          nextFocus: controller.focusLastName,
          action: TextInputAction.next,
          keyboardType: TextInputType.name,
        ),
        SizedBox(height: 16),
        Input(
          controller: controller.lastName,
          label: "Last name",
          labelColor: Palette.light,
          showClear: true,
          prefixIcon: Icon(LineIcons.user),
          focus: controller.focusLastName,
          nextFocus: controller.focusPhone,
          action: TextInputAction.next,
          keyboardType: TextInputType.name,
        ),
        SizedBox(height: 16),
        Input(
          controller: controller.phone,
          label: "Phone number",
          labelColor: Palette.light,
          showClear: true,
          prefixIcon: Icon(LineIcons.phone),
          focus: controller.focusPhone,
          action: TextInputAction.done,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
