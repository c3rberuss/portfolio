import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megalibreria/src/blocs/order/bloc.dart';
import 'package:megalibreria/src/models/orders/order_detail_model.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/utils/functions.dart';
import 'package:megalibreria/src/utils/screen_utils.dart';

class OrderItem extends StatelessWidget {
  final double marginBottom;
  final OrderDetailModel product;
  final int index;

  OrderItem({this.marginBottom = 0, @required this.product, @required this.index});

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Container(
      margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: marginBottom),
      child: Card(
        color: _theme.palette.white,
        elevation: 8,
        shadowColor: _theme.palette.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      width: screenWidth(context) * 0.2,
                      height: screenWidth(context) * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: screenWidth(context) * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "X${product.quantity}",
                        style: TextStyle(
                          fontSize: 17,
                          color: _theme.palette.dark.withOpacity(0.3),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.02,
                      ),
                      SizedBox(
                        width: screenWidth(context) * 0.67,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: screenWidth(context) * 0.50,
                              child: Text(
                                "${product.name}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _theme.palette.dark.withOpacity(0.7)),
                              ),
                            ),
                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(62),
                child: IconButton(
                  padding: EdgeInsets.all(5),
                  splashColor: _theme.palette.secondary.withOpacity(0.3),
                  icon: Icon(Icons.clear, color: _theme.palette.primary),
                  onPressed: () async {
                    final response = await showConfirmation(
                      context,
                      "Eliminar producto",
                      "¿Está seguro de eliminar este producto de su orden?",
                      ok: "Eliminar",
                      cancel: "Cancelar",
                    );

                    if (response) {
                      BlocProvider.of<OrderBloc>(context).add(RemoveItemEvent(index));

                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
