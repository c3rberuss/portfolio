import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpapers/src/models/image_model.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class ImageItem extends StatelessWidget {
  final ImageModel data;
  final double marginRight;
  final double marginLeft;
  final double marginBottom;

  final Function(String) onTap;

  ImageItem({this.marginRight, this.marginLeft, this.marginBottom, @required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {

    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Container(
      height: screenHeight(context) * 0.32,
      width: screenWidth(context),
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
      child: Card(
        color: _theme.palette.secondary.withOpacity(0.05),
        child: InkWell(
          onTap: (){
            if(onTap != null){
              onTap(data.url);
            }
          },
          borderRadius: BorderRadius.circular(16),
          child:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: CachedNetworkImageProvider(data.url),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
