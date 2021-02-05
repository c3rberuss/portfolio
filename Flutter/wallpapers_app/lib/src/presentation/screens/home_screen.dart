import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpapers/src/blocs/categories/categories_bloc.dart';
import 'package:wallpapers/src/blocs/categories/categories_event.dart';
import 'package:wallpapers/src/blocs/categories/categories_state.dart';
import 'package:wallpapers/src/blocs/images/images_bloc.dart';
import 'package:wallpapers/src/blocs/images/images_event.dart';
import 'package:wallpapers/src/blocs/images/images_state.dart';
import 'package:wallpapers/src/presentation/widgets/category_item.dart';
import 'package:wallpapers/src/presentation/widgets/image_item.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/delegates/images_search_delegate.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class HomeScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.palette.background,
        centerTitle: true,
        elevation: 0,
        title: Text("Wallpapers HD", style: TextStyle(color: _theme.palette.secondary)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ImagesSearchDelegate(_theme));
            },
          )
        ],
        bottom: PreferredSize(
          child: SizedBox(
            height: screenHeight(context) * 0.07,
            child: BlocConsumer<CategoriesBloc, CategoriesState>(
              builder: (BuildContext context, CategoriesState state) {
                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryItem(
                      data: state.categories[index],
                      active: index == state.categorySelected,
                      onTap: () {
                        BlocProvider.of<CategoriesBloc>(context)
                            .add(ChangeCategorySelectedEvent(index));
                      },
                    );
                  },
                );
              },
              listener: (BuildContext context, CategoriesState state) {
                if (state.externalChange && !state.manualChange) {
                  _scrollController.animateTo(0,
                      duration: Duration(seconds: 1), curve: Curves.bounceIn);
                }

                if (state.manualChange &&
                    !state.externalChange &&
                    state.categorySelected != state.categorySelectedAnt) {
                  BlocProvider.of<ImagesBloc>(context).add(
                    LoadImagesFromCategoryEvent(
                        state.categories[state.categorySelected].partialUrl),
                  );
                }
              },
            ),
          ),
          preferredSize: Size(double.infinity, screenHeight(context) * 0.07),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocConsumer<ImagesBloc, ImagesState>(
            listener: (BuildContext context, ImagesState state) {

              if(state.internetError){
                Navigator.pushNamedAndRemoveUntil(context, "/network", (route) => false);
              }

              if(state.providerError){
                Navigator.pushNamedAndRemoveUntil(context, "/oops", (route) => false);
              }

              if (state.refreshingFinalized) {
                _refreshController.refreshCompleted();
                if (state.page >= state.totalPages) {
                  _refreshController.loadNoData();
                }
                print("refreshing");
                //BlocProvider.of<CategoriesBloc>(context).add(InitialCategoryEvent());
              }

              if (state.loadingMoreFinalized) {
                _refreshController.loadComplete();

                if (state.page >= state.totalPages) {
                  _refreshController.loadNoData();
                }
              }
            },
            builder: (BuildContext context, ImagesState state) {
              if (state.fetchingFinalized) {
                return Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: _refreshController,
                    onRefresh: () {
                      BlocProvider.of<ImagesBloc>(context).add(RefreshImagesEvent());
                    },
                    onLoading: () {
                      BlocProvider.of<ImagesBloc>(context).add(LoadMoreImagesEvent());
                    },
                    child: GridView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: state.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        double margin = 0;

                        if (index + 1 == state.images.length) {
                          margin = 8;
                        }

                        return FadeInUp(
                          child: ImageItem(
                            data: state.images[index],
                            onTap: (route) {
                              Navigator.pushNamed(context, "/image", arguments: state.images[index]);
                            },
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 3/5
                      ),
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
          ),
        ],
      ),
    );
  }
}
