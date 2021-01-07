import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:megalibreria/src/models/products/product_model.dart';
import 'package:megalibreria/src/models/products/product_type.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/utils/clip_label.dart';

class ProductItem extends StatelessWidget {
  final ProductModel data;
  final Function onAdd;
  final Function onAddToWishList;
  final GlobalKey btnKey = GlobalKey();

  ProductItem({
    @required this.data,
    @required this.onAdd,
    @required this.onAddToWishList,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          child: Card(
            shadowColor: _theme.palette.secondary,
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: constraints.biggest.width,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: data.image,
                          width: constraints.biggest.width * 0.8,
                          height: constraints.biggest.width * 0.8,
                          fit: BoxFit.cover,
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
                            ));
                          },
                        ),
                      ),
                      ClipPath(
                        clipper: ClipLabel(),
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.only(left: 4, top: 4, bottom: 4, right: 10),
                          decoration: BoxDecoration(
                            color: data.type == ProductType.physical
                                ? (data.stock > 0 ? GFColors.SUCCESS : GFColors.DANGER)
                                : GFColors.SUCCESS,
                          ),
                          child: AutoSizeText(
                            data.type == ProductType.physical
                                ? (data.stock > 0
                                    ? "\$${data.price.toStringAsFixed(2)}"
                                    : "AGOTADO")
                                : "\$${data.price.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 18, color: GFColors.WHITE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: GFTypography(
                      text: data.name,
                      textColor: GFColors.DARK.withOpacity(0.7),
                      dividerColor: GFColors.PRIMARY,
                    ),
                  ),
                ),
                Divider(color: GFColors.LIGHT),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GFIconButton(
                        type: GFButtonType.transparent,
                        shape: GFIconButtonShape.circle,
                        icon: Icon(
                          Icons.favorite_border,
                          color: GFColors.DANGER,
                          size: 25,
                        ),
                        onPressed: onAddToWishList,
                      ),
                      GFIconButton(
                        type: GFButtonType.transparent,
                        shape: GFIconButtonShape.circle,
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: GFColors.PRIMARY,
                          size: 25,
                        ),
                        onPressed: onAdd,
                      ),
                    ],
                  ),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      },
    );
  }
}
