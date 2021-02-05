import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/application/application_bloc.dart';
import 'package:services/src/blocs/application/application_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (BuildContext context, ApplicationState state) {
        return AppBar(
          title: Text('appbarTitle'),
          elevation: 0,
          actions: <Widget>[
            Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, "resume");
                },
              ),
              badgeContent: Text(
                state.count.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              toAnimate: true,
              position: BadgePosition.topRight(top: 0, right: 5),
              showBadge: state.count > 0,
            )
          ],
        );
      },
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
