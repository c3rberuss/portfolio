import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/application/application_bloc.dart';
import 'package:services/src/blocs/application/application_event.dart';
import 'package:services/src/blocs/application/application_state.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (BuildContext context, ApplicationState state) {
        return Badge(
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              //application.getCost();
              BlocProvider.of<ApplicationBloc>(context).add(ObtainLocation());
              Navigator.pushNamed(context, "resume");
            },
          ),
          badgeContent: Text(
            //application.count.toString(),
            state.count.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          toAnimate: true,
          position: BadgePosition.topRight(top: 0, right: 5),
          showBadge: state.count > 0,
        );
      },
    );
  }
}
