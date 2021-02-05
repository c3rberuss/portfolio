import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpapers/src/blocs/categories/categories_bloc.dart';
import 'package:wallpapers/src/blocs/categories/categories_event.dart';
import 'package:wallpapers/src/models/category_model.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel data;
  final bool active;
  final Function onTap;

  CategoryItem({@required this.data, @required this.active, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: this.active ? _theme.palette.secondary : Colors.white30.withOpacity(0.4),
          borderRadius: BorderRadius.circular(62),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            data.name,
            style: TextStyle(
              color: this.active ? Colors.white.withOpacity(0.6) : _theme.palette.background,
              fontWeight: this.active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        )
      ),
      onTap: onTap,
    );
  }

/*  Chip(
  shadowColor: !this.active ? _theme.palette.secondary : Colors.white30.withOpacity(0.4),
  backgroundColor: this.active ? _theme.palette.secondary : Colors.white30.withOpacity(0.4),
  label: 
  ),*/
}
