import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:megalibreria/src/blocs/change_password/change_password_form_bloc.dart';
import 'package:megalibreria/src/presentation/widgets/dialog.dart';
import 'package:megalibreria/src/presentation/widgets/input.dart';
import 'package:megalibreria/src/presentation/widgets/progress_dialog.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/repositories/user_repository.dart';
import 'package:megalibreria/src/utils/functions.dart';
import 'package:megalibreria/src/utils/screen_utils.dart';
import 'package:megalibreria/src/utils/styles.dart';

class SelectYearMonthDialog extends StatefulWidget {
  @override
  _SelectYearMonthDialogState createState() => _SelectYearMonthDialogState();
}

class _SelectYearMonthDialogState extends State<SelectYearMonthDialog> {
  DateTime date = DateTime.now().add(Duration(days: 1));
  dp.DatePickerRangeStyles styles = dp.DatePickerRangeStyles(
    selectedPeriodLastDecoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
    ),
    selectedPeriodStartDecoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
      ),
    ),
    selectedPeriodMiddleDecoration: BoxDecoration(
      color: Colors.yellow,
      shape: BoxShape.rectangle,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Dialog(
      backgroundColor: _theme.palette.white,
      insetAnimationCurve: Curves.elasticIn,
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Select expiration date",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
                dp.MonthPicker(
                  selectedDate: date,
                  datePickerStyles: dp.DatePickerStyles(
                    currentDateStyle: TextStyle(
                      color: GFColors.PRIMARY,
                      fontWeight: FontWeight.w500,
                    ),
                    displayedPeriodTitle: TextStyle(
                      color: GFColors.PRIMARY,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedDateStyle: TextStyle(
                      color: GFColors.WHITE,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedSingleDateDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: GFColors.PRIMARY,
                    ),
                    disabledDateStyle: TextStyle(
                      color: GFColors.LIGHT,
                    ),
                  ),
                  onChanged: (_date) {
                    setState(() {
                      date = _date;
                    });
                  },
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
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
                      text: "Cancel",
                    ),
                    SizedBox(width: 20),
                    GFButton(
                      shape: GFButtonShape.standard,
                      type: GFButtonType.solid,
                      onPressed: () {
                        Navigator.pop(context, date);
                      },
                      text: "Ok",
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
