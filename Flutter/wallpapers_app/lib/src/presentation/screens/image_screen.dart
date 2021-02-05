import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:wallpapers/src/blocs/image/image_bloc.dart';
import 'package:wallpapers/src/blocs/image/image_event.dart';
import 'package:wallpapers/src/blocs/image/image_state.dart';
import 'package:wallpapers/src/models/image_model.dart';
import 'package:wallpapers/src/presentation/widgets/action_image.dart';
import 'package:wallpapers/src/presentation/widgets/bottom_sheet.dart';
import 'package:wallpapers/src/presentation/widgets/snackbar.dart';
import 'package:wallpapers/src/repositories/data_repository.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/functions.dart';
import 'package:wallpapers/src/utils/palette.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ImageModel image = ModalRoute.of(context).settings.arguments;
    final _theme = RepositoryProvider.of<ThemeRepository>(context);
    // ignore: close_sinks
    final _bloc = ImageBloc(
      RepositoryProvider.of<DataRepository>(context),
      _theme.palette,
      context,
    );

    _bloc.add(FetchImageEvent(image.name, image.category));

    final ProgressDialog _progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      textDirection: TextDirection.ltr,
    )..style(
        backgroundColor: _theme.palette.background,
        messageTextStyle: TextStyle(
          fontWeight: FontWeight.w300,
          color: _theme.palette.textColor,
          fontSize: 18,
        ),
        message: "Downloading image, please wait!",
        progressWidget: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ),
      );

    return Scaffold(
      backgroundColor: _theme.palette.background,
      body: SafeArea(
        child: BlocConsumer<ImageBloc, ImageState>(
          bloc: _bloc,
          listener: (BuildContext context, ImageState state) async {

            if (state.success) {
              await _progressDialog.hide();
              //showMessage(context, "Wallpaper set successfully", "Success");
              //await Navigator.pushNamed(context, "/crop", arguments: state.url);
              Scaffold.of(context).showSnackBar(_buildSnackBar(
                context,
                _theme,
                "Success",
                "Image configured as wallpaper successfully",
                SnackBarType.success,
              ));

            }

            if (state.downloading && !state.success && !state.error) {
              print("Downloading");
              if(!_progressDialog.isShowing()){
                await _progressDialog.show();
              }else{
                await _progressDialog.hide();
              }
            }else{
              await _progressDialog.hide();
            }

            if(state.internetError){
              Navigator.pushNamedAndRemoveUntil(context, "/network", (route) => false);
            }

            if(state.providerError){
              Navigator.pushNamedAndRemoveUntil(context, "/oops", (route) => false);
            }

            if (state.error) {
              await _progressDialog.hide();
              //showMessage(context, "Wallpaper set successfully", "Success");
              //await Navigator.pushNamed(context, "/crop", arguments: state.url);
              Scaffold.of(context).showSnackBar(_buildSnackBar(
                context,
                _theme,
                "Error",
                "Image was not configured as wallpaper",
                SnackBarType.error,
              ));
            }
          },
          builder: (BuildContext context, ImageState state) {
            if (state.fetchingFinalized) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ExtendedImage.network(
                    state.image.url,
                    width: screenWidth(context),
                    fit: BoxFit.fitWidth,
                    clearMemoryCacheIfFailed: true,
                    cache: true,
                    enableMemoryCache: true,
                    filterQuality: FilterQuality.medium,
                    mode: ExtendedImageMode.gesture,
                    loadStateChanged: (ExtendedImageState imageState) {
                      if (imageState.extendedImageLoadState == LoadState.completed) {
                        return null;
                      }

                      if (imageState.extendedImageLoadState == LoadState.failed) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/error.png",
                              width: screenWidth(context) * 0.5,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(height: screenHeight(context) * 0.05),
                            Text(
                              "Error on show image",
                              style: TextStyle(
                                color: _theme.palette.textColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        );
                      }

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            SizedBox(height: screenHeight(context) * 0.02),
                            Text(
                              "Loading full size image",
                              style: TextStyle(fontSize: 18, color: _theme.palette.textColor),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: screenWidth(context),
                      color: _theme.palette.background.withOpacity(0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: _theme.palette.secondary,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
                      width: screenWidth(context),
                      color: _theme.palette.background.withOpacity(0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ActionImage(
                            icon: Icons.file_download,
                            text: "Download",
                            color: _theme.palette.secondary,
                            onTap: () {
                              //_bloc.add(DownloadImageEvent());
                              Scaffold.of(context).showSnackBar(_buildSnackBar(
                                context,
                                _theme,
                                "Comming soon",
                                "This function will be enable in next updates",
                                SnackBarType.info,
                              ));
                            },
                          ),
                          ActionImage(
                            icon: Icons.image,
                            text: "Set as wallpaper",
                            color: _theme.palette.secondary,
                            onTap: () async {

                              showMaterialModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context, scrollController) {
                                  return BlocBuilder<ImageBloc, ImageState>(
                                    bloc: _bloc,
                                    builder: (BuildContext context, ImageState state) {
                                      return CustomBottomSheet(
                                        home: state.home,
                                        lock: state.lock,
                                        both: state.both,
                                        homeChanged: (value) {
                                          _bloc.add(ChangeHomeEvent(value));
                                        },
                                        lockChanged: (value) {
                                          _bloc.add(ChangeLockEvent(value));
                                        },
                                        bothChanged: (value) {
                                          _bloc.add(ChangeBothEvent(value));
                                        },
                                        useCallback: () async {
                                          _bloc.add(SetImageAsWallpaperEvent());
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: screenHeight(context) * 0.03),
                  Text(
                    "Loading full size image",
                    style: TextStyle(fontSize: 18, color: _theme.palette.textColor),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SnackBar _buildSnackBar(BuildContext context, ThemeRepository _theme, String title, String text,
      [SnackBarType type = SnackBarType.info]) {
    return SnackBar(
      backgroundColor: _theme.palette.primary,
      elevation: 8,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _icon(type, _theme.palette),
                SizedBox(height: screenHeight(context)*0.02),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _theme.palette.textColor,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: screenHeight(context)*0.01),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: _theme.palette.textColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Icon _icon(SnackBarType type, Palette palette) {
    Icon icon;

    switch (type) {
      case SnackBarType.info:
        icon = Icon(Icons.info_outline, color: palette.textColor, size: 64);
        break;
      case SnackBarType.success:
        icon = Icon(Icons.check_circle_outline, color: palette.textColor, size: 64);
        break;
      case SnackBarType.error:
        icon = Icon(Icons.error_outline, color: palette.red, size: 64);
        break;
    }

    return icon;
  }
}
