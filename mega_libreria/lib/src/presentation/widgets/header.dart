import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Header extends StatelessWidget {
  final String text;
  final GFTypographyType type;
  final Color color;

  Header({@required this.text, this.type = GFTypographyType.typo3, this.color = GFColors.DARK});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: GFTypography(
        textColor: GFColors.DARK.withOpacity(0.7),
        type: type,
        text: text,
        icon: Icon(Icons.arrow_forward_ios, color: color.withOpacity(0.7), size: 16),
        showDivider: false,
      ),
    );
  }
}
