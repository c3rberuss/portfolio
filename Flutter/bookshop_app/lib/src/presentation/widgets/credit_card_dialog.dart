import 'package:bookshop/src/blocs/credit_card/credit_card_form_bloc.dart';
import 'package:bookshop/src/models/orders/card_model.dart';
import 'package:bookshop/src/presentation/widgets/select_year_dialog.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/functions.dart';
import 'package:bookshop/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class CreditCardDialog extends StatelessWidget {
  final _numberFocus = FocusNode();
  final _expDateFocus = FocusNode();
  final _cvvFocus = FocusNode();
  final _holderFocus = FocusNode();
  final formatter = DateFormat("MM/yy");

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return BlocProvider(
      create: (context) => CreditCardFormBloc(),
      child: Builder(
        builder: (BuildContext context) {
          // ignore: close_sinks
          final _bloc = context.bloc<CreditCardFormBloc>();

          return Dialog(
            backgroundColor: _theme.palette.white,
            insetAnimationCurve: Curves.elasticIn,
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Wrap(
              children: <Widget>[
                FormBlocListener<CreditCardFormBloc, CardModel, String>(
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
                            FontAwesomeIcons.solidCreditCard,
                            size: 50,
                            color: _theme.palette.info.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Información de pago",
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
                          textFieldBloc: _bloc.cardNumber,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: _numberFocus,
                          suffixButton: SuffixButton.clearText,
                          decoration:
                              Styles.inputDecorator(_theme.palette, label: "Número de tarjeta "),
                          nextFocusNode: _expDateFocus,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: CustomDialogFormBlocBuilder(
                                inputFieldBloc: _bloc.expDate,
                                animateWhenCanShow: true,
                                showSelected: (item) {
                                  return item != null ? formatter.format(item) : "";
                                },
                                focusNode: _expDateFocus,
                                nextFocusNode: _cvvFocus,
                                decoration:
                                    Styles.inputDecorator(_theme.palette, label: "Fecha exp."),
                                getValueFromDialog: () async {
                                  final date = await showDialog(
                                    context: context,
                                    child: SelectYearMonthDialog(),
                                  );

                                  return date;
                                },
                              ),
                            ),
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: _bloc.cvv,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                focusNode: _cvvFocus,
                                nextFocusNode: _holderFocus,
                                decoration: Styles.inputDecorator(_theme.palette, label: "CVV"),
                              ),
                            )
                          ],
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: _bloc.holder,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          suffixButton: SuffixButton.clearText,
                          decoration:
                              Styles.inputDecorator(_theme.palette, label: "Nombre de propietario"),
                          focusNode: _holderFocus,
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
