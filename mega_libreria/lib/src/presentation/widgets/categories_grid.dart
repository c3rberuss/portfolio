import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:megalibreria/src/blocs/categories/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'category_item.dart';

class CategoriesGrid extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (BuildContext context, CategoriesState state) {
        print(state.noInternet);

        if (state.noInternet) {
          print("NO INTERNET");
          //noInternetConnection(context);
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        }

        if (state.refreshingFinalized) {
          _refreshController.refreshCompleted(resetFooterState: true);
        }

        if (state.loadingMoreFinalized) {
          print("CATEGORIES: ${state.categories.length}");

          _refreshController.loadComplete();

          if (state.page == state.totalPages) {
            _refreshController.loadNoData();
          }
        }
      },
      builder: (BuildContext context, CategoriesState state) {
        if (state.fetchingFinalized) {
          return Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: () {
                BlocProvider.of<CategoriesBloc>(context).add(RefreshCategoriesEvent());
              },
              onLoading: () {
                BlocProvider.of<CategoriesBloc>(context).add(LoadMoreCategoriesEvent());
              },
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                padding: EdgeInsets.all(8),
                itemCount: state.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInDown(
                    child: CategoryItem(data: state.categories[index]),
                  );
                },
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.fit(1);
                },
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
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
