import 'package:app/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';

class CustomListItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String imageUrl;
  final bool multiLine;
  final bool svg;
  final Widget secondLine;
  final Widget thirdLine;

  CustomListItem({
    @required this.onTap,
    @required this.title,
    @required this.imageUrl,
    this.svg = false,
    this.multiLine = false,
    this.secondLine,
    this.thirdLine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 23, left: 23, right: 23),
      decoration: Styles.boxDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 2, top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    if (svg) ...[
                      SvgPicture.network(
                        imageUrl,
                        fit: BoxFit.fitHeight,
                        width: 80,
                        height: 80,
                      )
                    ] else ...[
                      Image.asset(
                        imageUrl,
                        fit: BoxFit.fitHeight,
                        width: 80,
                        height: 80,
                      ),
                    ],
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (this.multiLine) ...[
                            this.secondLine,
                            this.thirdLine,
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 64,
                  child: Icon(
                    LineIcons.arrow_right,
                    size: 32,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
