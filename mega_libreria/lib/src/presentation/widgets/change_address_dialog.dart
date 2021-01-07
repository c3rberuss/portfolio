import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:megalibreria/src/blocs/map/change_address_form_bloc.dart';
import 'package:megalibreria/src/models/addresses/address_model.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/utils/functions.dart';
import 'package:megalibreria/src/utils/styles.dart';

class ChangeAddressDialog extends StatelessWidget {

  final String address;
  final _addressFocus = FocusNode();
  final _numberFocus = FocusNode();


  ChangeAddressDialog(this.address);

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return BlocProvider(
      create: (context) => ChangeAddressFormBloc(),
      child: Builder(
        builder: (BuildContext context) {
          // ignore: close_sinks
          final _bloc = context.bloc<ChangeAddressFormBloc>();
          _bloc.address.updateInitialValue(address);

          return Dialog(
            backgroundColor: _theme.palette.white,
            insetAnimationCurve: Curves.elasticIn,
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Wrap(
              children: <Widget>[
                FormBlocListener<ChangeAddressFormBloc, AddressModel, String>(
                  onSuccess: (context, state) async {
                    Navigator.pop(context, state.successResponse);
                  },
                  onFailure: (context, state) async {
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
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 50,
                            color: _theme.palette.info.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Complete la información",
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
                          textFieldBloc: _bloc.address,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: _addressFocus,
                          suffixButton: SuffixButton.clearText,
                          decoration:
                          Styles.inputDecorator(_theme.palette, label: "Dirección"),
                          nextFocusNode: _numberFocus,
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: _bloc.houseNumber,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          focusNode: _numberFocus,
                          suffixButton: SuffixButton.clearText,
                          decoration:
                          Styles.inputDecorator(_theme.palette, label: "Número de casa"),
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
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(width: 20),
                              GFButton(
                                text: "Terminar",
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
