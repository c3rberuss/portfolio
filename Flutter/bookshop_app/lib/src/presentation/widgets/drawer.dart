import 'package:bookshop/src/blocs/profile/bloc.dart';
import 'package:bookshop/src/presentation/widgets/change_password_dialog.dart';
import 'package:bookshop/src/repositories/auth_repository.dart';
import 'package:bookshop/src/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (BuildContext context, ProfileState state) {
                  return GFDrawerHeader(
                    otherAccountsPictures: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/profile", arguments: true);
                        },
                      ),
                    ],
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          GFColors.PRIMARY,
                          GFColors.INFO,
                        ],
                      ),
                    ),
                    closeButton: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: GFColors.WHITE,
                        size: 14,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GFAvatar(
                          radius: 35.0,
                          backgroundImage: AssetImage("assets/icons/user.png"),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "${state.user.name} ${state.user.lastName}",
                          style: TextStyle(color: GFColors.WHITE, fontSize: 18),
                        ),
                        Text(
                          state.user.email,
                          style: TextStyle(color: GFColors.WHITE),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.user),
                title: Text('Cuenta'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.heart),
                title: Text('Mi lista de deseos'),
                onTap: null,
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.listUl),
                title: Text('Mis órdenes'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/orders");
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.edit),
                title: Text('Cambiar contraseña'),
                onTap: () async {
                  final success = await showDialog(context: context, child: ChangePasswordDialog());

                  if (success is bool && success) {
                    RepositoryProvider.of<AuthRepository>(context).logout();
                    RepositoryProvider.of<ProfileBloc>(context).add(ClearSessionEvent());
                    Navigator.pushReplacementNamed(context, "/auth");
                  }
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Divider(color: GFColors.PRIMARY),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: GFButton(
                  text: "Cerrar sessión",
                  color: GFColors.DANGER,
                  icon: Icon(Icons.arrow_back, color: GFColors.WHITE),
                  blockButton: true,
                  onPressed: () async {
                    final response = await showConfirmation(
                        context, "Cuenta", "¿Está seguro de querer cerrar su sesión?",
                        ok: "Si, cerrar sesión", cancel: "Cancelar");

                    if (response) {
                      RepositoryProvider.of<AuthRepository>(context).logout();
                      await Navigator.pushNamedAndRemoveUntil(context, "/auth", (route) => false);
                      RepositoryProvider.of<ProfileBloc>(context).add(ClearSessionEvent());
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
