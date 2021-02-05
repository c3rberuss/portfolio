import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpapers/src/blocs/categories/categories_bloc.dart';
import 'package:wallpapers/src/blocs/categories/categories_event.dart';
import 'package:wallpapers/src/blocs/images/images_bloc.dart';
import 'package:wallpapers/src/blocs/images/images_event.dart';
import 'package:wallpapers/src/presentation/screens/crop_screen.dart';
import 'package:wallpapers/src/presentation/screens/home_screen.dart';
import 'package:wallpapers/src/presentation/screens/image_screen.dart';
import 'package:wallpapers/src/presentation/screens/not_network_connection_screen.dart';
import 'package:wallpapers/src/presentation/screens/troubles_screen.dart';
import 'package:wallpapers/src/repositories/data_repository.dart';
import 'package:wallpapers/src/repositories/data_repository_impl.dart';
import 'package:wallpapers/src/repositories/network_repository.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/constants.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class App extends StatelessWidget {
  final themeRepository = ThemeRepository();
  final textStyle = TextStyle(color: Colors.grey.withOpacity(0.5));

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NetworkRepository>(
          create: (BuildContext context) {
            return NetworkRepository(baseUrl: BASE_URL);
          },
        ),
        RepositoryProvider<ThemeRepository>(
          create: (BuildContext context) {
            return themeRepository;
          },
        ),
        RepositoryProvider<DataRepository>(
          create: (BuildContext context) {
            return DataRepositoryImpl(context.repository<NetworkRepository>());
          },
        ),
        //more repositories
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CategoriesBloc>(
            create: (ctx) => CategoriesBloc(ctx.repository<DataRepository>(), ctx),
          ),
          BlocProvider<ImagesBloc>(
            create: (ctx) => ImagesBloc(ctx.repository<DataRepository>()),
          ),
        ],
        child: RefreshConfiguration(
          headerBuilder: () => WaterDropHeader(
            complete: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check, color: Colors.grey.withOpacity(0.8)),
                SizedBox(width: 8),
                Text("All images are updated", style: textStyle)
              ],
            ),
            waterDropColor: themeRepository.palette.secondary,
          ),
          footerBuilder: () => ClassicFooter(
            loadingText: "Loading more images...",
            noDataText: "Nothing to show",
            canLoadingText: "Load more images",
            idleText: "Swipe up to loading more images",
            failedText: "It can't load more images",
          ),
          enableScrollWhenRefreshCompleted: true,
          //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
          enableLoadingWhenFailed: true,
          //In the case of load failure, users can still trigger more loads by gesture pull-up.
          hideFooterWhenNotFull: false,
          // Disable pull-up to load more functionality when Viewport is less than one screen
          enableBallisticLoad: true,
          // trigger load more by BallisticScrollActivity
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeRepository.theme,
            home: Builder(
              builder: (context) {
                return SplashScreen.callback(
                  name: 'assets/loading.flr',
                  backgroundColor: context.repository<ThemeRepository>().palette.background,
                  startAnimation: 'Alarm',
                  loopAnimation: 'Alarm',
                  endAnimation: 'Alarm',
                  height: screenHeight(context) * 0.46,
                  width: screenWidth(context),
                  until: () async {

                    try {
                      await context.repository<DataRepository>().fetchCategories();

                      context.bloc<CategoriesBloc>().add(FetchCategoriesEvent());
                      context.bloc<ImagesBloc>().add(FetchImagesEvent());

                      return Future.value("/home");
                    } on DioError catch (error) {
                      print("SOCKET: $error");

                      if (error.type == DioErrorType.DEFAULT) {
                        return Future.value("/network");
                      } else if (error.type == DioErrorType.RESPONSE) {
                        return Future.value("/oops");
                      }
                    }
                  },
                  onSuccess: (data) {
                    Navigator.pushNamedAndRemoveUntil(context, data, (r) => false);
                  },
                  onError: (error, stacktrace) {
                    print(error);
                    Navigator.pushNamedAndRemoveUntil(context, "/oops", (r) => false);
                  },
                );
              },
            ),
            routes: {
              '/home': (context) => HomeScreen(),
              '/image': (context) => ImageScreen(),
              '/crop': (context) => CropScreen(),
              '/network': (context) => NoInternetConnectionScreen(),
              '/oops': (context) => TroublesScreen(),
            },
          ),
        ),
      ),
    );
  }
}
