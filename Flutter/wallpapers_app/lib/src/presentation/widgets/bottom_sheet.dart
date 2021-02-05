import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class CustomBottomSheet extends StatelessWidget {
  final bool home;
  final bool lock;
  final bool both;
  final Function(bool) homeChanged;
  final Function(bool) lockChanged;
  final Function(bool) bothChanged;
  final Function useCallback;

  final style = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.4),
  );

  CustomBottomSheet({
    this.home = false,
    this.lock = false,
    this.both = false,
    @required this.homeChanged,
    @required this.lockChanged,
    @required this.bothChanged,
    @required this.useCallback,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: screenWidth(context),
            height: screenHeight(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.01, sigmaY: 5.01),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: screenWidth(context),
            height: screenHeight(context) * 0.5,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _theme.palette.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: screenWidth(context) * 0.1,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _theme.palette.secondary,
                    borderRadius: BorderRadius.circular(62),
                  ),
                ),
                SizedBox(height: screenHeight(context) * 0.05),
                Text(
                  "Set as Wallpaper",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                Divider(
                  color: _theme.palette.secondary,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Home", style: style),
                    Switch.adaptive(
                      value: home,
                      onChanged: homeChanged,
                      activeColor: _theme.palette.secondary,
                      inactiveThumbColor: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Lock Screen", style: style),
                    Switch.adaptive(
                      value: lock,
                      onChanged: lockChanged,
                      activeColor: _theme.palette.secondary,
                      inactiveThumbColor: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Home + Lock Screen", style: style),
                    Switch.adaptive(
                      value: both,
                      onChanged: bothChanged,
                      activeColor: _theme.palette.secondary,
                      inactiveThumbColor: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(context) * 0.05),
                MaterialButton(
                  color: _theme.palette.secondary,
                  disabledColor: _theme.palette.secondary.withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
                  minWidth: screenWidth(context) * 0.8,
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: home || lock || both
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),
                  onPressed: home || lock || both ? useCallback : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
