import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallpapers/src/blocs/crop/bloc.dart' as bloc;
import 'package:wallpapers/src/presentation/widgets/action_image.dart';
import 'package:wallpapers/src/presentation/widgets/bottom_sheet.dart';
import 'package:wallpapers/src/presentation/widgets/snackbar.dart';
import 'package:wallpapers/src/repositories/theme_repository.dart';
import 'package:wallpapers/src/utils/palette.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';

class CropScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final imageUrl = ModalRoute.of(context).settings.arguments;
    final _theme = RepositoryProvider.of<ThemeRepository>(context);
    // ignore: close_sinks
    final _bloc = bloc.CropBloc(context);

    return Scaffold(
      backgroundColor: _theme.palette.background,
      body: SafeArea(
        top: true,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
/*            Positioned(
              top: 80,
              bottom: 80,
              left: 0, right: 0,
              child: ExtendedImage.file(
                File(imageUrl),
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                extendedImageEditorKey: cropKey,
                scale: 9/16,
                initEditorConfigHandler: (state) {
                  return EditorConfig(
                    maxScale: 5,
                    cropAspectRatio: 9 / 16,
                  );
                },
              ),
            ),*/
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
                padding: EdgeInsets.all(8),
                width: screenWidth(context),
                color: _theme.palette.background.withOpacity(0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ActionImage(
                      icon: Icons.check,
                      text: "Ok",
                      color: _theme.palette.secondary,
                      onTap: () async {
                        showMaterialModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context, scrollController) {
                            return BlocBuilder<bloc.CropBloc, bloc.CropState>(
                              bloc: _bloc,
                              builder: (BuildContext context, bloc.CropState state) {
                                return CustomBottomSheet(
                                  home: state.home,
                                  lock: state.lock,
                                  both: state.both,
                                  homeChanged: (value) {
                                    _bloc.add(bloc.ChangeHomeEvent(value));
                                  },
                                  lockChanged: (value) {
                                    _bloc.add(bloc.ChangeLockEvent(value));
                                  },
                                  bothChanged: (value) {
                                    _bloc.add(bloc.ChangeBothEvent(value));
                                  },
                                  useCallback: () async {
                                    /*_bloc.add(SetImageAsWallpaperEvent(
                                        cropKey.currentState.getCropRect(), imageUrl));*/
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
                SizedBox(height: screenHeight(context) * 0.02),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _theme.palette.textColor,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: screenHeight(context) * 0.01),
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
