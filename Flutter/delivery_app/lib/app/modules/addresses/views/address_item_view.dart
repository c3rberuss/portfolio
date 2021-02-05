import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AddressItemView extends StatelessWidget {
  final _style = TextStyle(fontSize: 12);

  final String name;
  final String address;
  final String ref;
  final bool selected;
  final int maxLines;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  AddressItemView({
    @required this.name,
    @required this.address,
    @required this.ref,
    this.selected = false,
    this.maxLines,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Styles.boxDecoration(
        background: selected ? Palette.light : Palette.white,
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                        maxLines: maxLines ?? 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        address,
                        maxLines: maxLines ?? 3,
                        overflow: TextOverflow.ellipsis,
                        style: _style,
                      ),
                      Text(
                        ref,
                        maxLines: maxLines ?? 1,
                        overflow: TextOverflow.ellipsis,
                        style: _style,
                      ),
                    ],
                  ),
                ),
                if (selected) ...[
                  Icon(LineIcons.check),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
