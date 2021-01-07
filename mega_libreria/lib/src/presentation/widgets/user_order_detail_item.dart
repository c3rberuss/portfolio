import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megalibreria/src/models/orders/order_detail_model.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/utils/screen_utils.dart';

class OrderDetailItem extends StatelessWidget {
  final double marginBottom;
  final OrderDetailModel product;
  final int index;

  OrderDetailItem({this.marginBottom = 0, @required this.product, @required this.index});

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Container(
      margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: marginBottom),
      child: Card(
        color: _theme.palette.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
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
                    borderRadius: BorderRadius.circular(16),
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
                        "x${product.quantity}",
                        style: TextStyle(fontSize: 17, color: Colors.grey.withOpacity(0.7)),
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
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
          ],
        ),
      ),
    );
  }
}
