import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpapers/src/blocs/images/images_bloc.dart';
import 'package:wallpapers/src/blocs/images/images_event.dart';
import 'package:wallpapers/src/blocs/images/images_state.dart';
import 'package:wallpapers/src/presentation/widgets/image_item.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/hexcolor.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class ImagesSearchDelegate extends SearchDelegate {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  ThemeRepository _theme;
  TextStyle _style;

  ImagesSearchDelegate(this._theme)
      : _style = TextStyle(fontSize: 18, color: _theme.palette.textColor);

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
          BlocProvider.of<ImagesBloc>(context).add(ClearResultsEvent());
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        BlocProvider.of<ImagesBloc>(context).add(ClearResultsEvent());
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if (BlocProvider.of<ImagesBloc>(context).state.query != query) {
      BlocProvider.of<ImagesBloc>(context).add(SearchImagesEvent(query));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocConsumer<ImagesBloc, ImagesState>(
          listener: (BuildContext context, ImagesState state) {
            if (state.internetError) {
              Navigator.pushNamedAndRemoveUntil(context, "/network", (route) => false);
            }

            if (state.providerError) {
              Navigator.pushNamedAndRemoveUntil(context, "/oops", (route) => false);
            }

            if (state.loadingMoreResultsFinalized) {
              _refreshController.loadComplete();

              if (state.pageSearch >= state.totalPagesSearch) {
                _refreshController.loadNoData();
              }
            }
          },
          builder: (BuildContext context, ImagesState state) {
            if (state.fetchingResultsFinalized) {
              if (state.imagesSearch.isEmpty && query.isNotEmpty) {
                return _notFound(context);
              } else if (state.imagesSearch.isEmpty && query.isEmpty) {
                return _search(context);
              }

              return Expanded(
                child: SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  controller: _refreshController,
                  onLoading: () {
                    BlocProvider.of<ImagesBloc>(context).add(LoadMoreResultsEvent());
                  },
                  child: GridView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: state.imagesSearch.length,
                    itemBuilder: (BuildContext context, int index) {
                      double margin = 0;

                      if (index + 1 == state.imagesSearch.length) {
                        margin = 8;
                      }

                      return FadeInUp(
                        child: ImageItem(
                          data: state.imagesSearch[index],
                          onTap: (name) {
                            Navigator.pushNamed(context, "/image",
                                arguments: state.imagesSearch[index]);
                          },
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 3 / 5,
                    ),
                  ),
                ),
              );
            } else if (state.fetchingSearch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return _notFound(context);
          },
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _search(context);
  }

  Widget _notFound(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(
            "assets/not_found.png",
            width: screenWidth(context) * 0.5,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: screenHeight(context) * 0.05),
          Text("Wallpapers not founds!", style: _style),
        ],
      ),
    );
  }

  Widget _search(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.search, size: 64, color: _theme.palette.secondary),
          SizedBox(height: screenHeight(context) * 0.02),
          Text(
            "Search wallpapers",
            style: _style,
          ),
        ],
      ),
    );
  }
}
