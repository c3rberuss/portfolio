import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog({
    Key key,
    this.background = "ffffff",
    @required this.title,
    this.content = "",
    this.okButtonText = "Aceptar",
    this.cancelButtonText = "Cancelar",
  });

  final String background;
  final String title;
  final String content;
  final String okButtonText;
  final String cancelButtonText;
  final List<Widget> buttons = List();

  @override
  Widget build(BuildContext context) {
    final _palette = RepositoryProvider.of<ThemeRepository>(context).palette;

    return Dialog(
      backgroundColor: HexColor(this.background),
      insetAnimationCurve: Curves.elasticIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 8),
        child: Wrap(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Icon(
                    FontAwesomeIcons.questionCircle,
                    color: _palette.primary.withOpacity(0.5),
                    size: 64,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _palette.dark.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GFButton(
                      shape: GFButtonShape.standard,
                      type: GFButtonType.outline,
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      text: cancelButtonText,
                    ),
                    SizedBox(width: 20),
                    GFButton(
                      shape: GFButtonShape.standard,
                      type: GFButtonType.solid,
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      text: okButtonText,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
