import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/utils/screen_utils.dart';

class EmptyContent extends StatelessWidget {
  final String text;

  EmptyContent(this.text);

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset(
              "assets/icons/search.png",
              width: screenWidth(context) * 0.4,
              fit: BoxFit.fitWidth,
            ),
            Container(
              width: screenWidth(context) * 0.4,
              height:  screenWidth(context) * 0.4,
              color: Colors.white.withOpacity(0.8),
            ),
          ],
        ),
        SizedBox(height: screenHeight(context) * 0.05, width: screenWidth(context)),
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: _theme.palette.dark.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}
