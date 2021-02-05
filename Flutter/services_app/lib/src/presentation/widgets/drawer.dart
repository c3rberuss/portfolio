import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:services/src/blocs/application/bloc.dart';
import 'package:services/src/blocs/history/history_bloc.dart';
import 'package:services/src/blocs/history/history_event.dart';
import 'package:services/src/blocs/user/user_bloc.dart';
import 'package:services/src/blocs/user/user_state.dart';
import 'package:services/src/repositories/auth_repository.dart';
import 'package:services/src/utils/hexcolor.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          BlocBuilder<UserBloc, UserState>(
            builder: (BuildContext context, UserState state) {
              return DrawerHeader(
                padding: EdgeInsets.all(0),
                child: Container(
                  color: HexColor("#ffffff"),
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/user.png"),
                          radius: 45,
                        ),
                        SizedBox(height: 16),
                        Text(state.data.name),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.user),
            title: Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "profile");
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.history),
            title: Text("History"),
            onTap: () {
              BlocProvider.of<HistoryBloc>(context).add(FetchHistoryEvent());
              Navigator.pushNamed(context, "history");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text("Logout"),
            onTap: () {
              //logout(context);
              BlocProvider.of<ApplicationBloc>(context).add(ClearApplicationEvent());
              RepositoryProvider.of<AuthRepository>(context).logout();
              Navigator.pushReplacementNamed(context, "auth");
            },
          ),
        ],
      ),
    );
  }
}
