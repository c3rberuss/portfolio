import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megalibreria/src/models/orders/order_model.dart';
import 'package:megalibreria/src/presentation/widgets/user_order_detail_item.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';

import 'empty.dart';

class OrdersList extends StatelessWidget {
  final OrderModel data;

  OrdersList(this.data);

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    if (data.detail.isEmpty) {
      return EmptyContent("La orden no posee un detalle");
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: constraints.biggest.height*0.72,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index == data.detail.length - 1) {
                    return OrderDetailItem(
                      marginBottom: 16,
                      product: data.detail[index],
                      index: index,
                    );
                  }

                  return OrderDetailItem(
                    product: data.detail[index],
                    index: index,
                  );
                },
                itemCount: data.detail.length,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              height: constraints.biggest.height*0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(color: _theme.palette.secondary),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Subtotal", style: TextStyle(fontSize: 18)),
                      Text("\$${data.total}", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Envío", style: TextStyle(fontSize: 18)),
                      Text("\$${data.fareDelivery}", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total", style: TextStyle(fontSize: 18)),
                      Text("\$${(data.total+data.fareDelivery).toStringAsFixed(2)}", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
