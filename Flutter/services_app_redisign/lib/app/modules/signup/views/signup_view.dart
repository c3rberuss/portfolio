import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/modules/signup/controllers/signup_controller.dart';
import 'package:services/app/modules/signup/views/personal_info_form.dart';
import 'package:services/app/styles/palette.dart';

import 'account_info_form.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Create an ",
                style: context.textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Palette.light,
                ),
              ),
              TextSpan(
                text: "Account",
                style: context.textTheme.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Palette.light,
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Material(
        child: Hero(
          tag: "container",
          child: Theme(
            data: context.theme.copyWith(
              primaryColor: Palette.lightSecondary,
            ),
            child: Container(
              height: double.infinity,
              color: Palette.primary,
              child: CoolStepper(
                config: CoolStepperConfig(
                  icon: Icon(LineIcons.info, color: Palette.lightSecondary),
                  titleTextStyle: context.textTheme.headline6.copyWith(
                    color: Palette.lightSecondary,
                  ),
                  subtitleTextStyle: context.textTheme.subtitle2.copyWith(
                    color: Palette.grey,
                  ),
                  stepperTextStyle: context.textTheme.subtitle2.copyWith(
                    color: Palette.grey,
                  ),
                  buttonsPadding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                ),
                nextButton: (onPressed, buttonText) {
                  return MaterialButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
                    color: Palette.success.withOpacity(0.8),
                    textColor: Palette.light,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
                backButton: (onPressed, buttonText) {
                  return FlatButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
                    textColor: Palette.lightSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
                finishButton: (onPressed, buttonText) {
                  return FlatButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
                    textColor: Palette.light,
                    color: Palette.success.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
                onCompleted: () {
                  Get.back();
                },
                steps: [
                  CoolStep(
                    title: "Personal Info",
                    subtitle: "Complete with real information",
                    content: PersonalInfoForm(),
                    validation: () {
                      if (!controller.isValidPersonalInfo()) {
                        return "Fields are required";
                      }
                      return null;
                    },
                  ),
                  CoolStep(
                    title: "Account Info",
                    subtitle: "Complete with your credentials",
                    content: AccountInfoForm(),
                    validation: () {
                      if (!controller.isValidAccountInfo()) {
                        return "Fields are required";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
