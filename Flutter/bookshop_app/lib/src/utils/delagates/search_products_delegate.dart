import 'package:bookshop/src/blocs/products/bloc.dart';
import 'package:bookshop/src/blocs/products/products_event.dart';
import 'package:bookshop/src/presentation/widgets/add_product_bottom_sheet.dart';
import 'package:bookshop/src/presentation/widgets/empty.dart';
import 'package:bookshop/src/presentation/widgets/product_item.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../styles.dart';

class SearchProductsDelegate extends SearchDelegate {
  final ThemeRepository _theme;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  SearchProductsDelegate(this._theme);

  @override
  String get searchFieldLabel => "Buscar";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return _theme.appBarTheme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          BlocProvider.of<ProductsBloc>(context).add(ClearSearchEvent());
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        BlocProvider.of<ProductsBloc>(context).add(ClearSearchEvent());
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return results(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 3) {
      return results(context);
    }

    return Center(
      child: EmptyContent("Busque sus productos favoritos!"),
    );
  }

  Widget results(BuildContext context) {
    if (!BlocProvider.of<ProductsBloc>(context).state.query.startsWith(query)) {
      BlocProvider.of<ProductsBloc>(context).add(SearchProductsEvent(query));
    }

    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (BuildContext context, ProductsState state) {
        if (state.noInternet) {
          //noInternetConnection(context);
        }

        if (state.loadingMoreFinalizedSearch) {
          _refreshController.loadComplete();

          if (state.page == state.totalPages) {
            _refreshController.loadNoData();
          }
        }
      },
      builder: (BuildContext context, ProductsState state) {
        if (state.fetchingFinalizedSearch) {
          return SmartRefresher(
            controller: _refreshController,
            enablePullUp: state.pageSearch < state.totalPagesSearch,
            enablePullDown: false,
            onLoading: () {
              BlocProvider.of<ProductsBloc>(context).add(LoadMoreSearchProductsEvent());
            },
            child: state.searchProducts.isEmpty
                ? EmptyContent("No se ha encontrado ningun producto.")
                : StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(8),
                    itemCount: state.searchProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductItem(
                        data: state.searchProducts[index],
                        onAdd: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            bounce: true,
                            backgroundColor: GFColors.WHITE,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                            builder: (ctx, controller) {
                              return AddProductBottomSheet(
                                state.searchProducts[index],
                                onSuccess: () {
                                  Scaffold.of(context).showSnackBar(Styles.snackBar(
                                      "Se agregó al carrito exitosamente!", _theme.palette));
                                },
                              );
                            },
                          );
                        },
                        onAddToWishList: () {
                          context
                              .bloc<ProductsBloc>()
                              .add(AddToWishListEvent(state.searchProducts[index].id));
                          Scaffold.of(context).showSnackBar(Styles.snackBar(
                              "Se agregó a su lista de deseos exitosamente!", _theme.palette));
                        },
                      );
                    },
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.fit(1);
                    },
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
          );
        } else if (state.fetchingSearch) {
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
