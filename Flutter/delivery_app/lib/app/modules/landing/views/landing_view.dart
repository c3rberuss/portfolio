import 'package:app/app/modules/landing/controllers/landing_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/custom_dialog.dart';
import 'package:app/app/widgets/progress_dialog.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/exceptions/auth_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingView extends GetView<LandingController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: Container(
            margin: EdgeInsets.all(31),
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.45,
                  height: Get.width * 0.45,
                  child: Placeholder(),
                ),
                SizedBox(height: 16),
                Text(
                  "Bienvenido",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Delivery App",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Somos el servicio de entregas a domicilio con ",
                        style: TextStyle(
                          color: Palette.dark,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: "los mejores precios",
                        style: TextStyle(
                          color: Palette.dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: " del mercado. ¿No nos crees?",
                        style: TextStyle(
                          color: Palette.dark,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: " Compruébalo",
                        style: TextStyle(
                          color: Palette.dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25),
                CustomOutlineButton(
                  text: "Ingresar",
                  fullWidth: true,
                  maxWidth: 500,
                  minWidth: 500,
                  buttonType: CustomButtonType.dark,
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: FacebookButton(
                        text: "Facebook",
                        onPressed: () async {
                          ProgressDialog.show(context);
                          final result = await controller.signInWithFacebook();
                          _checkResult(context, result);
                        },
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: GoogleButton(
                        text: "Google",
                        onPressed: () async {
                          ProgressDialog.show(context);
                          final result = await controller.signInWithGoogle();
                          _checkResult(context, result);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                CustomFillButton(
                  text: "Regístrate",
                  buttonType: CustomButtonType.dark,
                  fullWidth: true,
                  maxWidth: 500,
                  minWidth: 500,
                  onPressed: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkResult(BuildContext context, Resource<String> result) {
    ProgressDialog.hide(context);

    //If the authentication is successful then redirect to home screen
    if (result is Success<String>) {
      Get.offAllNamed(Routes.HOME);

      //If the auth failed then show an snack bar
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
