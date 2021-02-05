import 'package:bookshop/src/models/args/order_args.dart';
import 'package:bookshop/src/models/orders/order_model.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/datetime.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderItem extends StatelessWidget {
  final int index;
  final OrderModel data;
  final double marginBottom;

  UserOrderItem({@required this.data, @required this.marginBottom, this.index});

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Container(
      margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: marginBottom),
      width: screenWidth(context),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Card(
            color: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${data.company}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _theme.palette.secondary,
                      ),
                    ),
                    Divider(
                      color: _theme.palette.primary,
                    ),
                    if (data.address != null) ...[
                      SizedBox(
                        width: constraints.biggest.width,
                        child: Text(
                          "${data.address.address}, ",
                          style: TextStyle(fontSize: 17),
                        ),
                      )
                    ],
                    SizedBox(height: 8),
                    Text(
                      "Orden realizada ${formatDatetime(data.date, data.time)}",
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(height: 8),
                    Divider(
                      color: _theme.palette.primary,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${data.orderNumber}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${data.status}",
                          style: TextStyle(
                            fontSize: 14,
                            color: _theme.palette.primary.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Total: \$${(data.total + data.fareDelivery).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/detail', arguments: OrderArgs(order: data));
              },
            ),
          );
        },
      ),
    );
  }
}
