import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:megalibreria/src/blocs/products/bloc.dart';
import 'package:megalibreria/src/presentation/widgets/add_product_bottom_sheet.dart';
import 'package:megalibreria/src/presentation/widgets/product_item.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/utils/styles.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'empty.dart';

class ProductsGrid extends StatelessWidget {
  final int id;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  ProductsGrid(this.id);

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Expanded(
      child: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (BuildContext context, ProductsState state) {
          print("PAGE: ${state.page}");
          print("TOTAL PAGES: ${state.totalPages}");

          if (state.noInternet) {
            //noInternetConnection(context);
          }

          if (state.refreshingFinalized) {
            _refreshController.refreshCompleted(resetFooterState: true);
          }

          if (state.loadingMoreFinalized) {
            _refreshController.loadComplete();
            if (state.page == state.totalPages) {
              _refreshController.loadNoData();
            }
          }
        },
        builder: (BuildContext context, ProductsState state) {
          if (state.fetchingFinalized) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: state.page < state.totalPages,
              onRefresh: () {
                BlocProvider.of<ProductsBloc>(context).add(RefreshProductsEvent(id));
              },
              onLoading: () {
                BlocProvider.of<ProductsBloc>(context).add(LoadMoreProductsEvent(id));
              },
              child: state.products.isEmpty
                  ? EmptyContent("Este establecimiento aún no ofrece ningún producto.")
                  : StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      padding: EdgeInsets.all(8),
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(
                          data: state.products[index],
                          onAdd: () async {
                            await showMaterialModalBottomSheet(
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
                                  state.products[index],
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
                                .add(AddToWishListEvent(state.products[index].id));
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
