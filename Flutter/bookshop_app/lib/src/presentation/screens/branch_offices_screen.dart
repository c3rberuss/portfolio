import 'package:badges/badges.dart';
import 'package:bookshop/src/models/branches/branch_model.dart';
import 'package:bookshop/src/presentation/widgets/branch_item.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class BranchOfficesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        iconTheme: ThemeData.light().iconTheme.copyWith(color: GFColors.PRIMARY),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Sucursales",
          style: TextStyle(color: GFColors.PRIMARY),
        ),
        backgroundColor: GFColors.WHITE,
        actions: <Widget>[
          Badge(
            showBadge: true,
            badgeContent: Text(
              "0",
              style: TextStyle(color: GFColors.WHITE),
            ),
            badgeColor: GFColors.DANGER,
            position: BadgePosition.topRight(top: 0, right: 3),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: GFColors.PRIMARY,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return BranchItem(
            data: BranchModel(
              (b) => b
                ..image = ""
                ..name = "Example"
                ..id = 1
                ..status = 1
                ..idCategory = 1,
            ),
          );
        },
      ),
    );
  }
}
