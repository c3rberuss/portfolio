import 'dart:math' as math;

import 'package:bookshop/src/models/branches/branch_model.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class BranchItem extends StatelessWidget {
  final BranchModel data;
  final double marginRight;
  final double marginLeft;
  final double marginBottom;

  final Function(String) onTap;

  BranchItem({
    this.marginRight = 0,
    this.marginLeft = 0,
    this.marginBottom = 0,
    @required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.406,
      width: screenWidth(context),
      //margin: EdgeInsets.only(bottom: marginBottom),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap(data.name);
          }
        },
        child: Card(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: <Widget>[
                  Positioned(
                    child: Transform.rotate(
                      angle: (1 / 4) * math.pi,
                      child: Image.asset(
                        "assets/images/book.png",
                        //scale: 3,
                        width: constraints.biggest.width * 0.9,
                        height: constraints.biggest.height,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    right: -constraints.biggest.width * 0.2,
                    top: -constraints.biggest.height * 0.15,
                  ),
                  Container(
                    //padding: EdgeInsets.all(8),
                    height: constraints.biggest.height,
                    decoration: BoxDecoration(
                      color: GFColors.WHITE.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    right: 8,
                    top: 8,
                    bottom: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: GFColors.DARK.withOpacity(0.7)),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.mapMarkerAlt, color: GFColors.PRIMARY),
                          title: Text("Encuéntranos"),
                          subtitle: Text("2da calle poniente #205, San Miguel"),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone_iphone, color: GFColors.PRIMARY),
                          title: Text("Llámanos"),
                          subtitle: Text("+503 2606 7632"),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.whatsapp, color: GFColors.PRIMARY),
                          title: Text("WhatsApp"),
                          subtitle: Text("+503 7925-8790"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          elevation: 4,
          shadowColor: GFColors.PRIMARY,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
