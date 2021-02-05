import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookshop/src/models/orders/order_state_model.dart';
import 'package:bookshop/src/models/orders/order_states_response.dart';
import 'package:bookshop/src/models/orders/record_node.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:bookshop/src/utils/palette.dart';
import 'package:built_collection/built_collection.dart';
import 'package:timeline_node/timeline_node.dart';

import './bloc.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final UserRepository _repository;
  final Palette _palette;

  RecordBloc(this._repository, this._palette);

  @override
  RecordState get initialState => RecordState.initial();

  @override
  Stream<RecordState> mapEventToState(
    RecordEvent event,
  ) async* {
    if (event is FetchRecordEvent) {
      yield state.copyWith(fetching: true, orderId: event.orderId);
      yield* _mapRequest(event.orderId);
    } else if (event is RefreshRecordEvent) {
      yield state.copyWith(refreshingFinalized: false);
      yield* _mapRequest(state.orderId, refresh: true);
    } else if (event is ClearStateEvent) {
      yield RecordState.initial();
    }
  }

  Stream<RecordState> _map404() async* {
    yield state.copyWith(
      refreshingFinalized: true,
      fetching: false,
      fetchingFinalized: true,
    );
  }

  Stream<RecordState> _mapRequest(int orderId, {bool refresh = false}) async* {
    final response = await _repository.getRecord(orderId, true);
    if (response.code == 200) {
      if (!refresh) {
        yield* _mapFetch(response);
      } else if (refresh) {
        yield* _mapRefresh(response);
      }
    } else if (response.code == 404) {
      yield* _map404();
    } else {
      print("Session Expired");
    }
  }

  Stream<RecordState> _mapFetch(OrderStatesResponse response) async* {
    yield state.copyWith(
      fetching: false,
      fetchingFinalized: true,
      records: _nodes(response.data),
    );
  }

  Stream<RecordState> _mapRefresh(OrderStatesResponse response) async* {
    yield state.copyWith(
      refreshingFinalized: true,
      records: _nodes(response.data),
    );
  }

  List<RecordNode> _nodes(BuiltList<OrderStateModel> data) {
    return data.map((s) {
      final index = data.indexOf(s);

      TimelineNodeStyle style;

      if (data.length > 1) {
        print("MAYOR 1");

        if (index == 0) {
          style = TimelineNodeStyle(
            type: TimelineNodeType.Left,
            lineType: TimelineNodeLineType.BottomHalf,
            lineWidth: 3,
            lineColor: _palette.primary,
          );
        } else if (index == data.length - 1) {
          style = TimelineNodeStyle(
            type: TimelineNodeType.Left,
            lineType: TimelineNodeLineType.TopHalf,
            lineWidth: 3,
            lineColor: _palette.primary,
          );
        } else {
          style = TimelineNodeStyle(
            type: TimelineNodeType.Left,
            lineType: TimelineNodeLineType.Full,
            lineWidth: 3,
            lineColor: _palette.primary,
          );
        }
      } else {
        print("IGUAL 0");

        style = TimelineNodeStyle(
          type: TimelineNodeType.Left,
          lineType: TimelineNodeLineType.None,
          lineWidth: 3,
          lineColor: _palette.primary,
        );
      }

      return RecordNode(style: style, record: s);
    }).toList();
  }
}
