import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:services/src/blocs/application/application_bloc.dart';
import 'package:services/src/blocs/application/application_event.dart';
import 'package:services/src/blocs/application/application_state.dart';
import 'package:services/src/models/card_model.dart';
import 'package:services/src/presentation/widgets/application_detail_list.dart';
import 'package:services/src/presentation/widgets/bottom_sheet.dart';
import 'package:services/src/presentation/widgets/dialog.dart';
import 'package:services/src/presentation/widgets/separators.dart';
import 'package:services/src/utils/functions.dart';

class ResumeScreen extends StatefulWidget {
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ApplicationBloc _bloc;
  CustomBottomSheet _bottomSheet;
  ProgressDialog _progressDialog;
  TextStyle _textStyle;

  @override
  void initState() {
    super.initState();

    // ignore: close_sinks
    _bloc = BlocProvider.of<ApplicationBloc>(context);

    _bottomSheet = CustomBottomSheet(
      closeBottomSheet: () {
        _bloc.add(ShowOrHideBottomSheet());
      },
    );

    _progressDialog =
        ProgressDialog(context, type: ProgressDialogType.Download, isDismissible: false)
          ..style(
              message: 'Please Wait',
              borderRadius: 8.0,
              backgroundColor: Colors.white,
              elevation: 12,
              insetAnimCurve: Curves.easeInOut,
              maxProgress: 100.0,
              progress: 0.0);

    _textStyle = TextStyle(fontSize: 20, color: Colors.black54);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplicationBloc, ApplicationState>(
      listener: (context, state) async {
        if (state.servicesRemoved) {
          showMessage(context, "Service removed", DialogType.Success, "Services");
        } else if (state.sendingApplication) {
          _progressDialog.show();
        } else if (state.updating) {
          _progressDialog.update(
            maxProgress: 100.0,
            progress: state.percent,
            message: state.message,
          );
        } else if (state.finishSuccess) {
          _progressDialog.hide();

          if (state.onlyApplicationWithoutPayment) {
            await showMessage(context, state.message, DialogType.Info);
          } else {
            await showMessage(context, state.message);
          }
          _bloc.add(ClearApplicationEvent());
          Navigator.pop(context);
        } else if (state.finishError) {
          _progressDialog.hide();
          _showError(state.message);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          _bloc.add(UnselectedAllEvent());
          _bloc.add(ShowOrHideBottomSheet(forceClose: true));

          pop(context);
          return Future.value(false);
        },
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            actions: <Widget>[
              BlocBuilder<ApplicationBloc, ApplicationState>(
                builder: (BuildContext context, ApplicationState state) {
                  return IconButton(
                    icon: Icon(FontAwesomeIcons.trashAlt),
                    onPressed: state.countSelected > 0
                        ? () async {
                            _bloc.add(RemoveServicesEvent());
                          }
                        : null,
                  );
                },
              )
            ],
          ),
          body: BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (BuildContext context, ApplicationState state) {
              return ApplicationDetailList(state.application.services);
            },
          ),
          //buildBody(provider.servicesSelected),
          bottomNavigationBar: BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (BuildContext context, ApplicationState state) {
              return Card(
                borderOnForeground: false,
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: state.allSelected,
                            onChanged: (value) {
                              //provider.allSelected = value;
                              _bloc.add(SelectAllEvent(value));
                            },
                          ),
                          Text("All"),
                        ],
                      ),
                      if (state.calculatingCost) ...[
                        CircularProgressIndicator()
                      ] else ...[
                        FlatButton.icon(
                          onPressed: () async {
                            _bloc.add(ShowOrHideBottomSheet());
                          },
                          icon: Icon(FontAwesomeIcons.ellipsisV),
                          label: Text(state.totFinal),
                        ),
                      ],
                      FlatButton(
                        onPressed: !state.calculatingCost
                            ? () async {
                                if (state.files.length > 0 &&
                                    state.application.services.length > 0) {
                                  //payment
                                  await showResume(context, state.totalFinalNum, state.toPaid);
                                } else if (state.application.services.length == 0) {
                                  _bloc.add(ShowOrHideBottomSheet(forceClose: true));
                                  Navigator.pop(context);
                                } else {
                                  if (!state.sheetOpened) {
                                    _bloc.add(ShowOrHideBottomSheet());
                                  }

                                  final File image =
                                      await ImagePicker.pickImage(source: ImageSource.camera);

                                  if (image != null) {
                                    _bloc.add(AddImageEvent(image));
                                  }
                                }
                              }
                            : null,
                        child: Text(_buildTextForButton(state)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          bottomSheet: BlocBuilder<ApplicationBloc, ApplicationState>(
            condition: (prev, state) {
              return prev.sheetOpened != state.sheetOpened;
            },
            builder: (BuildContext context, ApplicationState state) {
              if (state.sheetOpened) {
                return _bottomSheet;
              }

              return Container(
                height: 0,
                width: 0,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> showResume(BuildContext context, double total, double toPaid) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text("About of your Payment"),
          titleTextStyle: TextStyle(color: Colors.blue, fontSize: 26),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "You need to paid half of the total",
                  textAlign: TextAlign.center,
                  style: _textStyle,
                ),
                Chip(
                  label: Text("\$${total.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  backgroundColor: Colors.blue,
                ),
                separatorV(20),
                Text(
                  "You Paid",
                  style: TextStyle(color: Colors.black54, fontSize: 20),
                ),
                Chip(
                  label: Text("\$${toPaid.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  backgroundColor: Colors.blue,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(ctx, false);
              },
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            FlatButton(
              onPressed: () async {
                final card = await Navigator.pushNamed(context, "card");
                if (card != null && card is CardModel) {
                  _bloc.add(SendApplicationEvent(card));
                }
                Navigator.pop(ctx, true);
              },
              child: Text("PAY"),
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );

    return result;
  }

  String _buildTextForButton(ApplicationState state) {
    if (state.application.services.length == 0) {
      return "Add services";
    } else if (state.files.length == 0) {
      return "Add Images";
    } else {
      return "Pay";
    }
  }

  Future<void> _showError(String error) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return CustomDialog(
          title: "Application",
          content: error,
          dialogType: DialogType.Error,
        );
      },
    );
  }
}
