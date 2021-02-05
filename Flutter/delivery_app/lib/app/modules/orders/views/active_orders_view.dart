import 'package:flutter/material.dart';
import '../controllers/orders_controller.dart';
import 'package:get/get.dart';

import 'order_item_view.dart';

class ActiveOrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return OrderItemView();
              },
              childCount: 10,
            ),
          ),
        )
      ],
    );
  }
}
