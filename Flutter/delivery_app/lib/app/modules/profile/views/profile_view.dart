import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/custom_dialog.dart';
import 'package:app/app/widgets/progress_dialog.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';
import 'package:app/core/exceptions/auth_exceptions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/profile/controllers/profile_controller.dart';
import 'package:line_icons/line_icons.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            'Mi Perfíl',
            style: TextStyle(color: Palette.dark),
          ),
          centerTitle: true,
          pinned: true,
          backgroundColor: Palette.white,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  decoration: Styles.boxDecoration(),
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                  child: ObxValue<Rx<User>>((user) {
                    if (user.value.name == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mis datos personales",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                            ),
                            RaisedButton.icon(
                              onPressed: () {
                                Get.toNamed(Routes.EDIT_PROFILE);
                              },
                              icon: Icon(LineIcons.pencil, size: 15),
                              label: Text(
                                "Editar",
                                style: TextStyle(fontSize: 12),
                              ),
                              shape: Styles.shapeRounded(),
                              color: Palette.dark,
                              textColor: Palette.white,
                              padding: EdgeInsets.zero,
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(user.value.image),
                          maxRadius: 50,
                          backgroundColor: Palette.lightSecondary,
                        ),
                        SizedBox(height: 16),
                        Text(
                          user.value.name,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          user.value.email,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Tel: ${user.value.phone ?? "--"}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    );
                  }, controller.user),
                ),
                _ProfileItem(
                  icon: LineIcons.map_pin,
                  title: "Dirección predeterminada",
                  subtitle: "Dirección de ejemplo con mucho texto para provocar el overflox",
                  onTap: () {},
                ),
                _ProfileItem(
                  icon: LineIcons.question,
                  title: "Ayuda",
                  onTap: () {},
                ),
                _ProfileItem(
                  icon: LineIcons.info,
                  title: "Acerca de LLeGo SV",
                  onTap: () {},
                ),
                CustomFillButton(
                  text: "Cerrar Sesión",
                  buttonType: CustomButtonType.danger,
                  fullWidth: true,
                  maxWidth: 500,
                  minWidth: 500,
                  onPressed: () async {
                    await controller.signOut();
                    Get.offAllNamed(Routes.LANDING);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _checkResult(BuildContext context, Resource<String> result) {
    ProgressDialog.hide(context);
    if (result is Success<String>) {
      showDialog(
        context: context,
        child: CustomDialog(
          title: "Cuenta",
          content: result.data,
          dialogType: DialogType.Success,
        ),
      );
    } else if (result is Failure<String, AuthException>) {
      showDialog(
        context: context,
        child: CustomDialog(
          title: "Cuenta",
          content: result.exception.message,
          dialogType: DialogType.Error,
        ),
      );
    }
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  _ProfileItem({
    @required this.icon,
    @required this.title,
    this.subtitle,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: EdgeInsets.only(bottom: 16),
      decoration: Styles.boxDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(icon),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 14),
                      ),
                      if (subtitle != null && subtitle.isNotEmpty) ...[
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Icon(LineIcons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
