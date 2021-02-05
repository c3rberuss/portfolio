import 'package:bookshop/src/models/orders/order_model.dart';
import 'package:flutter/cupertino.dart';

class OrderArgs {
  final bool fromNotification;
  final OrderModel order;

  OrderArgs({this.fromNotification = false, @required this.order});
}
