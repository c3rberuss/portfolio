import 'package:bookshop/src/blocs/change_password/change_password_form_bloc.dart';
import 'package:bookshop/src/presentation/widgets/dialog.dart';
import 'package:bookshop/src/presentation/widgets/progress_dialog.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:bookshop/src/utils/functions.dart';
import 'package:bookshop/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:getwidget/getwidget.dart';

class ChangePasswordDialog extends StatelessWidget {
  final _currentFocus = FocusNode();
  final _newFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return BlocProvider(
      create: (context) => ChangePasswordFormBloc(
        context.repository<UserRepository>(),
      ),
      child: Builder(
        builder: (BuildContext context) {
          // ignore: close_sinks
          final _bloc = context.bloc<ChangePasswordFormBloc>();

          return Dialog(
            backgroundColor: _theme.palette.white,
            insetAnimationCurve: Curves.elasticIn,
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Wrap(
              children: <Widget>[
                FormBlocListener<ChangePasswordFormBloc, String, String>(
                  onSubmitting: (context, state) {
                    ProgressDialog.show(context);
                  },
                  onSuccess: (context, state) async {
                    ProgressDialog.hide(context);
                    await showMessage(context, state.successResponse, "Éxito", DialogType.Success);
                    Navigator.pop(context, true);
                  },
                  onFailure: (context, state) async {
                    ProgressDialog.hide(context);
                    await showError(context, state.failureResponse, "Error");
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Icon(
                            Icons.vpn_key,
                            size: 64,
                            color: _theme.palette.info.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "Cambiar contraseña",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: _theme.palette.dark.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: _bloc.currentPassword,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: _currentFocus,
                          suffixButton: SuffixButton.obscureText,
                          decoration:
                              Styles.inputDecorator(_theme.palette, label: "Contraseña actual"),
                          onSubmitted: (value) {
                            fieldFocusChange(context, _currentFocus, _newFocus);
                          },
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: _bloc.newPassword,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          focusNode: _newFocus,
                          suffixButton: SuffixButton.obscureText,
                          decoration:
                              Styles.inputDecorator(_theme.palette, label: "Nueva contraseña"),
                          onSubmitted: (value) {
                            fieldFocusChange(context, _newFocus);
                          },
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GFButton(
                                text: "Cancelar",
                                shape: GFButtonShape.standard,
                                type: GFButtonType.outline,
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                              SizedBox(width: 20),
                              GFButton(
                                text: "Cambiar contraseña",
                                shape: GFButtonShape.standard,
                                type: GFButtonType.solid,
                                onPressed: () {
                                  _bloc.submit();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
