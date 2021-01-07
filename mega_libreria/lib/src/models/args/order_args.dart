import 'package:flutter/cupertino.dart';
import 'package:megalibreria/src/models/orders/order_model.dart';

class OrderArgs {
  final bool fromNotification;
  final OrderModel order;

  OrderArgs({this.fromNotification = false, @required this.order});
}
