import 'package:flutter/cupertino.dart';
import 'package:timeline_node/timeline_node.dart';

import 'order_state_model.dart';

class RecordNode {
  final TimelineNodeStyle style;
  final OrderStateModel record;

  RecordNode({@required this.style, @required this.record});
}
