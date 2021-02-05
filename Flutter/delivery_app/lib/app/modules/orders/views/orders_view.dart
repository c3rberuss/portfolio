import 'package:app/app/modules/orders/views/active_orders_view.dart';
import 'package:app/app/modules/orders/views/order_history_view.dart';
import 'package:app/app/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/orders/controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.white,
          title: Text(
            'Mis Órdenes',
            style: TextStyle(color: Palette.dark),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Palette.dark,
            indicatorColor: Palette.success,
            tabs: [
              Tab(text: "Activas"),
              Tab(text: "Historial"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveOrdersView(),
            OrderHistoryView(),
          ],
        ),
      ),
    );
  }
}
