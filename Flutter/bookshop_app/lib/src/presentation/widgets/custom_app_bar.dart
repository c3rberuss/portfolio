import 'package:badges/badges.dart';
import 'package:bookshop/src/blocs/order/bloc.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/delagates/search_products_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';

class CustomAppBar extends PreferredSize {
  final String title;
  final bool showSearchButton;
  final bool showCart;
  final double elevation;
  final bool centerTitle;
  final List<Widget> actions;

  CustomAppBar({
    @required this.title,
    this.showSearchButton = false,
    this.showCart = true,
    this.elevation = 6.0,
    this.centerTitle = false,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return GFAppBar(
      iconTheme: ThemeData.light().iconTheme.copyWith(color: GFColors.PRIMARY),
      automaticallyImplyLeading: true,
      elevation: elevation,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(color: GFColors.PRIMARY, fontSize: 27),
      ),
      backgroundColor: GFColors.WHITE,
      actions: <Widget>[
        if (showSearchButton) ...[
          IconButton(
            icon: Icon(
              Icons.search,
              color: GFColors.PRIMARY,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchProductsDelegate(RepositoryProvider.of<ThemeRepository>(context)),
              );
            },
          ),
        ],
        if (showCart) ...[
          BlocBuilder<OrderBloc, OrderState>(
            builder: (BuildContext context, OrderState state) {
              return Badge(
                showBadge: state.detail.isNotEmpty,
                badgeContent: Text(
                  state.detail.length.toString(),
                  style: TextStyle(color: GFColors.WHITE),
                ),
                badgeColor: GFColors.DANGER,
                position: BadgePosition.topRight(top: 0, right: 3),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: GFColors.PRIMARY,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/resume");
                  },
                ),
              );
            },
          ),
          if (actions != null) ...[...actions]
        ],
      ],
    );
  }
}
