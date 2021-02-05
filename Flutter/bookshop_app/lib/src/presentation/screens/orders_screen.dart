import 'package:animate_do/animate_do.dart';
import 'package:bookshop/src/blocs/orders_user/bloc.dart';
import 'package:bookshop/src/presentation/widgets/custom_app_bar.dart';
import 'package:bookshop/src/presentation/widgets/empty.dart';
import 'package:bookshop/src/presentation/widgets/user_order_item.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrdersScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);
    BlocProvider.of<OrdersUserBloc>(context).add(FetchOrdersUserEvent());

    return Scaffold(
      appBar: CustomAppBar(
        title: "Historial de órdenes",
        showCart: false,
        showSearchButton: false,
      ),
      body: BlocConsumer<OrdersUserBloc, OrdersUserState>(
        listener: (BuildContext context, OrdersUserState state) {
          if (state.noInternet) {
            //noInternetConnection(context);
          }

          if (state.refreshingFinalized) {
            _refreshController.refreshCompleted(resetFooterState: true);
          }
        },
        builder: (BuildContext context, OrdersUserState state) {
          if (state.fetchingFinalized) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: () {
                BlocProvider.of<OrdersUserBloc>(context).add(RefreshOrdersUserEvent());
              },
              child: state.orders.isEmpty
                  ? EmptyContent("Aun no ha realizado ninguna orden.")
                  : ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        double margin = 0;

                        if (index + 1 == state.orders.length) {
                          margin = 8;
                        }

                        return FadeInUp(
                          child: UserOrderItem(
                              data: state.orders[index], marginBottom: margin, index: index),
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
      ),
    );
  }
}
