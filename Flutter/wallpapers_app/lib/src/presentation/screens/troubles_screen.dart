import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpapers/src/blocs/categories/categories_bloc.dart';
import 'package:wallpapers/src/blocs/categories/categories_event.dart';
import 'package:wallpapers/src/blocs/images/images_bloc.dart';
import 'package:wallpapers/src/blocs/images/images_event.dart';
import 'package:wallpapers/src/repositories/data_repository.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class TroublesScreen extends StatefulWidget {
  @override
  _TroublesScreenState createState() => _TroublesScreenState();
}

class _TroublesScreenState extends State<TroublesScreen> {

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
              "assets/sad.png",
              width: screenWidth(context) * 0.5,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: screenHeight(context) * 0.02),
            Text(
              "Sorry, we are experiencing problems with our supplier",
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
                    if(error.type == DioErrorType.RESPONSE){
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
