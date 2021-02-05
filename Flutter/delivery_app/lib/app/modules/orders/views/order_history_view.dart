import 'package:app/app/widgets/empty_content.dart';
import 'package:flutter/material.dart';
import '../controllers/orders_controller.dart';
import 'package:get/get.dart';

class OrderHistoryView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return EmptyContent(
      textLine1: "Aún no tienes historial de órdenes",
      textLine2: "¡Te invitamos a realizar un pedido!",
    );
  }
}
