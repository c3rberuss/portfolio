import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:services/src/blocs/detail/detail_bloc.dart';
import 'package:services/src/blocs/detail/detail_event.dart';
import 'package:services/src/blocs/history/history_bloc.dart';
import 'package:services/src/blocs/history/history_event.dart';
import 'package:services/src/blocs/history/history_state.dart';
import 'package:services/src/presentation/widgets/application.dart';

class HistoryScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _bloc = BlocProvider.of<HistoryBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("User History"),
      ),
      body: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (BuildContext context, HistoryState state) {
          if (state is HistorySuccessRefreshState) {
            _refreshController.refreshCompleted();
          }
        },
        builder: (BuildContext context, HistoryState state) {
          if (state is LoadingDataHistoryState || state is InitialHistoryState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HistorySuccessFetchState) {
            return _buildBody(
              child: ListView.builder(
                itemCount: state.applications.length,
                itemBuilder: (BuildContext context, int index) {
                  return ApplicationTile(
                    application: state.applications[index],
                    callback: () {
                      final id = state.applications[index].applicationId;
                      BlocProvider.of<DetailBloc>(context).add(FetchApplicationEvent(id));
                      Navigator.pushNamed(context, "detail");
                    },
                  );
                },
              ),
              bloc: _bloc,
            );
          } else if (state is EmptyHistoryState) {
            return _buildBody(
              child: Center(
                child: Text("You don't have applications."),
              ),
              bloc: _bloc,
            );
          }

          return null;
        },
      ),
    );
  }

  Widget _buildBody({@required Widget child, @required HistoryBloc bloc}) {
    return SmartRefresher(
      header: WaterDropHeader(waterDropColor: Colors.blue),
      onRefresh: () {
        bloc.add(RefreshHistoryEvent());
      },
      controller: _refreshController,
      child: child,
    );
  }
}
