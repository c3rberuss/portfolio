import 'package:bookshop/src/models/orders/record_node.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RecordState extends Equatable {
  final int orderId;
  final bool fetching;
  final bool fetchingFinalized;
  final bool refreshingFinalized;
  final List<RecordNode> records;

  RecordState({
    @required this.fetching,
    @required this.fetchingFinalized,
    @required this.refreshingFinalized,
    @required this.records,
    @required this.orderId,
  });

  factory RecordState.initial() {
    return RecordState(
      fetching: true,
      fetchingFinalized: false,
      refreshingFinalized: false,
      records: [],
      orderId: 0,
    );
  }

  RecordState copyWith({
    bool fetching,
    bool fetchingFinalized,
    bool refreshingFinalized,
    List<RecordNode> records,
    int orderId,
  }) {
    return RecordState(
      fetching: fetching ?? this.fetching,
      fetchingFinalized: fetchingFinalized ?? this.fetchingFinalized,
      refreshingFinalized: refreshingFinalized ?? this.refreshingFinalized,
      records: records ?? this.records,
      orderId: orderId ?? this.orderId,
    );
  }

  @override
  List<Object> get props => [
        fetching,
        records,
        refreshingFinalized,
        fetchingFinalized,
        orderId,
      ];
}
