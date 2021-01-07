import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:megalibreria/src/blocs/products/bloc.dart';
import 'package:megalibreria/src/models/args/products_args.dart';
import 'package:megalibreria/src/models/categories/category_model.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel data;
  final double marginRight;
  final double marginLeft;
  final double marginBottom;

  CategoryItem({
    @required this.data,
    this.marginRight = 0,
    this.marginLeft = 0,
    this.marginBottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Card(
      elevation: 5,
      shadowColor: _theme.palette.secondary.withOpacity(0.8),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<ProductsBloc>(context)
                  .add(ClearProductsStateEvent());

              Navigator.pushNamed(
                context,
                "/products",
                arguments: ProductsArgs(id: data.id, name: data.name),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: data.image,
                  fit: BoxFit.fitWidth,
                  width: constraints.biggest.width,
                  //screenWidth(context),
                  imageBuilder: (ctx, image) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      width: constraints.biggest.width * 0.8,
                      height: constraints.biggest.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (ctx, url) {
                    return Container(
                      width: constraints.biggest.width * 0.8,
                      height: constraints.biggest.width * 0.8,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorWidget: (ctx, url, _) {
                    return Center(
                      child: ClipRRect(
                        child: Image.asset(
                          "assets/images/no_image.jpg",
                          width: constraints.biggest.width * 0.8,
                          height: constraints.biggest.width * 0.8,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      )
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: SizedBox(
                    width: constraints.biggest.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(
                          data.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: GFColors.DARK.withOpacity(0.7),
                          ),
                        ),
                        Container(
                          height: 3,
                          width: constraints.biggest.width * 0.33,
                          decoration: BoxDecoration(
                            color: GFColors.PRIMARY,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

/*  GFTypography(
  text: data.name,
  type: GFTypographyType.typo5,
  dividerColor: GFColors.PRIMARY,
  textColor: GFColors.DARK.withOpacity(0.7),
  ),*/
}
