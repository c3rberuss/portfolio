import 'package:bookshop/src/blocs/record/bloc.dart';
import 'package:bookshop/src/presentation/widgets/record_item.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeline_node/timeline_node.dart';

import 'empty.dart';

class Records extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final int orderId;

  Records(this.orderId);

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);
    // ignore: close_sinks
    final _bloc = RecordBloc(RepositoryProvider.of<UserRepository>(context), _theme.palette);
    _bloc.add(FetchRecordEvent(orderId));

    return BlocConsumer<RecordBloc, RecordState>(
      bloc: _bloc,
      listener: (BuildContext context, RecordState state) {
        if (state.refreshingFinalized) {
          _refreshController.refreshCompleted(resetFooterState: true);
        }
      },
      builder: (BuildContext context, RecordState state) {
        if (state.fetchingFinalized) {
          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            primary: true,
            onRefresh: () {
              _bloc.add(RefreshRecordEvent());
            },
            child: state.records.isEmpty
                ? EmptyContent("Historial vacío")
                : ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: state.records.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TimelineNode(
                        style: state.records[index].style,
                        indicator: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: _theme.palette.primary,
                            border: Border(
                              top: BorderSide(color: _theme.palette.white, width: 5.0),
                              bottom: BorderSide(color: _theme.palette.white, width: 5.0),
                              left: BorderSide(color: _theme.palette.white, width: 5.0),
                              right: BorderSide(color: _theme.palette.white, width: 5.0),
                            ),
                            borderRadius: BorderRadius.circular(62),
                          ),
                        ),
                        child: RecordItem(state.records[index].record),
                      );
                    },
                  ),
          );
        } else if (state.fetching) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: Text("No deberías de estar viendo este mensaje"),
        );
      },
    );
  }
}
