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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/signup/controllers/signup_controller.dart';
import 'package:line_icons/line_icons.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  void initState() {
    super.initState();

    handleDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            leading: IconButton(
              icon: Icon(LineIcons.arrow_left),
              onPressed: Get.back,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 31, right: 31, bottom: 31),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: 100,
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Registro de ",
                        children: [
                          TextSpan(
                            text: "usuarios",
                            style: context.textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      style: context.textTheme.headline5,
                    ),
                  ),
                ),
                Input(
                  labelWidget: InputLabel(
                    firstText: "Ingrese su ",
                    secondText: "nombre",
                  ),
                  controller: controller.nameController,
                  errorColor: Palette.dangerDark,
                  prefixIcon: Icon(LineIcons.user),
                  focus: controller.nameFocus,
                  nextFocus: controller.emailFocus,
                  keyboardType: TextInputType.name,
                  action: TextInputAction.next,
                  validators: [
                    Validators.required,
                  ],
                ),
                SizedBox(height: 16),
                Input(
                  labelWidget: InputLabel(
                    firstText: "Ingrese su ",
                    secondText: "correo electrónico",
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
                    firstText: "Contraseña",
                    secondText: "",
                  ),
                  controller: controller.passwordController,
                  errorColor: Palette.dangerDark,
                  prefixIcon: Icon(LineIcons.key),
                  focus: controller.passwordFocus,
                  keyboardType: TextInputType.text,
                  action: TextInputAction.done,
                  isPassword: true,
                  showClear: false,
                  validators: [
                    Validators.required,
                    Validators.passwordLength,
                  ],
                ),
                SizedBox(height: 32),
                ObxValue<RxBool>(
                  (isEnabled) {
                    return CustomFillButton(
                      text: "Registrate",
                      onPressed: () {
                        _handleSignUp(controller);
                      },
                      fullWidth: true,
                      maxWidth: 500,
                      minWidth: 500,
                      isEnabled: isEnabled.value,
                      buttonType: CustomButtonType.dark,
                    );
                  },
                  controller.isFormValid,
                ),
                Divider(),
                Text.rich(
                  TextSpan(
                    text: "¿Ya posees una ",
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
                CustomOutlineButton(
                  text: "Ingresar",
                  buttonType: CustomButtonType.dark,
                  onPressed: () {
                    Get.offNamed(Routes.LOGIN);
                  },
                  fullWidth: true,
                  maxWidth: 500,
                  minWidth: 500,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleSignUp(SignUpController controller) async {
    ProgressDialog.show(context);
    final result = await controller.signUpWithEmail();
    ProgressDialog.hide(context);

    if (result is Success) {
      showDialog(
        context: context,
        barrierDismissible: false,
        child: CustomDialog(
          dialogType: DialogType.Info,
          title: "Registro",
          content: "Se ha enviado un correo de verificación, "
              "puede tardar unos minutos en llegar.",
          okButtonText: "Aceptar",
        ),
      );
    } else if (result is Failure<void, AuthException>) {
      showDialog(
        context: context,
        barrierDismissible: false,
        child: CustomDialog(
          dialogType: DialogType.Error,
          title: "Registro",
          content: result.exception.message,
          okButtonText: "Aceptar",
        ),
      );
    }
  }

  Future handleDynamicLinks() async {
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      var actionCode = deepLink.queryParameters['oobCode'];

      try {
        ProgressDialog.show(context);

        await FirebaseAuth.instance.checkActionCode(actionCode);
        await FirebaseAuth.instance.applyActionCode(actionCode);
        await FirebaseAuth.instance.currentUser.reload();

        ProgressDialog.hide(context);
        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        ProgressDialog.hide(context);

        if (e.code == 'invalid-action-code') {
          print('The code is invalid.');
        }
      }
    }
  }
}
