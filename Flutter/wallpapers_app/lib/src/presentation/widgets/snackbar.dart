import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';

enum SnackBarType {
  error, success, info
}

class CustomSnackBar extends StatelessWidget {

  final String text;
  final String title;
  final SnackBarType type;

  CustomSnackBar({@required this.text, @required this.title, this.type = SnackBarType.info});

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return SnackBar(
      backgroundColor: _theme.palette.background,
      elevation: 8,
      behavior: SnackBarBehavior.floating,
      content: Column(
        children: <Widget>[
          Text(title),
          Text(text)
        ],
      ),
    );
  }
}
