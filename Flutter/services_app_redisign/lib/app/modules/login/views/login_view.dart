import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/modules/login/controllers/login_controller.dart';
import 'package:services/app/routes/app_pages.dart';
import 'package:services/app/styles/palette.dart';
import 'package:services/app/widgets/app_logo.dart';
import 'package:services/app/widgets/buttons.dart';
import 'package:services/app/widgets/input.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.8,
            color: Palette.white,
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Center(
                        child: Hero(
                          tag: "logo",
                          child: AppLogo(
                            textColor: Palette.greyDark,
                            widthFactor: 0.35,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: "container",
                    child: Material(
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Palette.primary,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          border: Border(),
                          boxShadow: [
                            BoxShadow(
                              color: Palette.primary.withOpacity(0.5),
                              blurRadius: 16,
                              offset: Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Welcome!",
                                  style: context.theme.textTheme.headline5.copyWith(
                                    color: Palette.light,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Input(
                                controller: Get.find(tag: "email"),
                                showClear: true,
                                label: "Email",
                                labelColor: Palette.light,
                                prefixIcon: Icon(LineIcons.user),
                                validators: [
                                  emailValidator,
                                ],
                              ),
                              SizedBox(height: 16),
                              Input(
                                controller: Get.find(tag: "password"),
                                isPassword: true,
                                showClear: false,
                                label: "Password",
                                labelColor: Palette.light,
                                prefixIcon: Icon(LineIcons.key),
                              ),
                              SizedBox(height: 16),
                              CustomFilledButton(
                                onPressed: () {
                                  Get.toNamed(Routes.HOME);
                                },
                                text: "Sign In",
                              ),
                              SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Divider(color: Palette.grey),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "O",
                                      style: context.textTheme.subtitle1.copyWith(
                                        color: Palette.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(color: Palette.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              CustomFlatButton(
                                text: "Sign Up",
                                onPressed: () {
                                  Get.toNamed(Routes.SIGNUP);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getSize() {
    final RenderBox obj = _key.currentContext.findRenderObject();
    final size = obj.size;
    print(size.height);
  }

  String emailValidator(String value) {
    if (!value.isEmail) {
      return "Email format incorrect";
    }

    return null;
  }
}
