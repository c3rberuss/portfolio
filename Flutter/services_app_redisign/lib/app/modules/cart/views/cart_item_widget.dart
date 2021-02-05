import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/styles/palette.dart';

class CardItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(16),
            height: 74,
            width: 74,
            child: Image.asset(
              "assets/icons/settings.png",
              fit: BoxFit.fitHeight,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Palette.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  color: Palette.primary.withOpacity(0.05),
                  offset: Offset(0, 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Item name",
                  style: TextStyle(fontSize: 18, color: Palette.greyDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  "\$5.50",
                  style: TextStyle(fontSize: 18, color: Palette.greyDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              LineIcons.trash,
              color: Palette.danger,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
