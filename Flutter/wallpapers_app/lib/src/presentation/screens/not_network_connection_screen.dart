import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpapers/src/blocs/categories/categories_bloc.dart';
import 'package:wallpapers/src/blocs/categories/categories_event.dart';
import 'package:wallpapers/src/blocs/images/images_bloc.dart';
import 'package:wallpapers/src/blocs/images/images_event.dart';
import 'package:wallpapers/src/repositories/data_repository.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  @override
  _NoInternetConnectionScreenState createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState extends State<NoInternetConnectionScreen> {
  ThemeRepository _theme;
  bool reload;

  @override
  void initState() {
    super.initState();
    _theme = RepositoryProvider.of<ThemeRepository>(context);
    reload = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/connect.png",
              width: screenWidth(context) * 0.5,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: screenHeight(context) * 0.03),
            Text(
              "You need a internet connection for use this app",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _theme.palette.textColor,
                fontWeight: FontWeight.w300,
                fontSize: 30,
              ),
            ),
            SizedBox(height: screenHeight(context) * 0.04),
            if(!reload)...[
              IconButton(
                iconSize: 64,
                icon: Icon(Icons.refresh, color: _theme.palette.secondary),
                onPressed: () async {

                  setState(() {
                    reload = true;
                  });

                  try{
                    await context.repository<DataRepository>().fetchCategories();

                    context.bloc<CategoriesBloc>().add(FetchCategoriesEvent());
                    context.bloc<ImagesBloc>().add(FetchImagesEvent());

                    Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);

                  }on DioError catch (error){
                    print("SOCKET: $error");

                    if(error.type == DioErrorType.DEFAULT){
                      setState(() {
                        reload = false;
                      });
                    }
                  }

                },
              )
            ]else...[
              CircularProgressIndicator()
            ]
          ],
        ),
      ),
    );
  }
}
