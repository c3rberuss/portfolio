import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/utils/validators.dart';
import 'package:app/app/widgets/custom_appbar.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/custom_dialog.dart';
import 'package:app/app/widgets/input.dart';
import 'package:app/app/widgets/progress_dialog.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/exceptions/auth_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/login/controllers/login_controller.dart';
import 'package:line_icons/line_icons.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "LLeGo SV",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 37, right: 37, bottom: 37),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              width: Get.width,
              height: 50,
              child: Center(
                child: Text(
                  "Inicio de Sesión",
                  style: context.textTheme.headline5,
                ),
              ),
            ),
            FacebookButton(
              text: "Ingresa con Facebook",
              onPressed: () async {
                ProgressDialog.show(context);
                final result = await controller.signInWithFacebook();
                _checkResult(context, result);
              },
              fullWidth: true,
              maxWidth: 500,
              minWidth: 500,
            ),
            SizedBox(height: 16),
            GoogleButton(
              text: "Ingresa con google",
              onPressed: () async {
                ProgressDialog.show(context);
                final result = await controller.signInWithGoogle();
                _checkResult(context, result);
              },
              fullWidth: true,
              maxWidth: Get.height,
              minWidth: 350,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Divider(color: Palette.dark),
                ),
                Expanded(
                  child: Text(
                    "O",
                    style: context.textTheme.subtitle1.copyWith(
                      color: Palette.dark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Divider(color: Palette.dark),
                ),
              ],
            ),
            Input(
              labelWidget: InputLabel(
                firstText: "Ingrese su ",
                secondText: "correo eletrónico",
              ),
              controller: controller.emailController,
              errorColor: Palette.dangerDark,
              prefixIcon: Icon(LineIcons.user),
              focus: controller.emailFocus,
              nextFocus: controller.passwordFocus,
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
              validators: [
                Validators.required,
                Validators.emailFormat,
              ],
            ),
            SizedBox(height: 16),
            Input(
              labelWidget: InputLabel(
                firstText: "Ingrese su ",
                secondText: "contraseña",
              ),
              controller: controller.passwordController,
              errorColor: Palette.dangerDark,
              prefixIcon: Icon(LineIcons.key),
              isPassword: true,
              showClear: false,
              focus: controller.passwordFocus,
              keyboardType: TextInputType.text,
              validators: [
                Validators.required,
                Validators.passwordLength,
              ],
            ),
            SizedBox(height: 32),
            ObxValue<RxBool>((isEnabled) {
              return CustomOutlineButton(
                text: "Ingresar",
                onPressed: () async {
                  ProgressDialog.show(context);
                  final result = await controller.signInWithEmail();
                  _checkResult(context, result);
                },
                isEnabled: isEnabled.value,
                fullWidth: true,
                maxWidth: 500,
                minWidth: 500,
                buttonType: CustomButtonType.dark,
              );
            }, controller.isValidForm),
            Divider(color: Palette.dark),
            Text.rich(
              TextSpan(
                text: "¿No posees una ",
                style: TextStyle(fontSize: 15),
                children: [
                  TextSpan(
                    text: "cuenta",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  TextSpan(text: "?", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            SizedBox(height: 8),
            CustomFillButton(
              text: "Regístrate",
              buttonType: CustomButtonType.dark,
              onPressed: () {
                Get.offNamed(Routes.SIGNUP);
              },
              fullWidth: true,
              maxWidth: 500,
              minWidth: 500,
            ),
          ],
        ),
      ),
    );
  }

  void _checkResult(BuildContext context, Resource<String> result) {
    ProgressDialog.hide(context);

    if (result is Success<String>) {
      Get.offAllNamed(Routes.HOME);
    } else if (result is Failure<String, AuthException>) {
      if (!(result.exception is AuthCancelledException)) {
        showDialog(
          context: context,
          child: CustomDialog(
            title: "Autenticación",
            content: result.exception.message,
            dialogType: DialogType.Error,
          ),
        );
      }
    }
  }
}
