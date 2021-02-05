import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:services/src/blocs/credit_card/credit_card_bloc.dart';
import 'package:services/src/blocs/credit_card/credit_card_event.dart';
import 'package:services/src/blocs/credit_card/credit_card_state.dart';
import 'package:services/src/presentation/widgets/input.dart';
import 'package:services/src/utils/screen_utils.dart';

class CreditCardDialog extends StatefulWidget {
  @override
  _CreditCardDialogState createState() => _CreditCardDialogState();
}

class _CreditCardDialogState extends State<CreditCardDialog> {
  CreditCardBloc _bloc;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _bloc = CreditCardBloc();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      _bloc.add(CvvFocusedEvent(_focusNode.hasFocus));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(8),
      title: Column(
        children: <Widget>[
          BlocBuilder<CreditCardBloc, CreditCardState>(
            bloc: _bloc,
            builder: (BuildContext context, CreditCardState state) {
              return CreditCardWidget(
                width: getScreenWidth(context) * .9,
                cardNumber: state.cardNumber,
                expiryDate: state.expiryDate,
                cardHolderName: state.cardHolderName,
                cvvCode: state.cvvCode,
                showBackView: state.isCvvFocused,
              );
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Input(
              key: Key("cardNumber"),
              placeholder: "Card Number",
              keyboardType: TextInputType.number,
              formatter: [
                MaskTextInputFormatter(
                  mask: '#### #### #### ####',
                  filter: {"#": RegExp(r'[0-9]')},
                ),
              ],
              onTextChange: (cardNumber) {
                _bloc.add(ChangeCardNumberEvent(cardNumber));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: getScreenWidth(context) * .37,
                  child: Input(
                    key: Key("expire"),
                    placeholder: "Expire date",
                    keyboardType: TextInputType.number,
                    formatter: [
                      MaskTextInputFormatter(
                        mask: '*#/+-',
                        filter: {
                          "#": RegExp(r'[0-2]'),
                          "*": RegExp(r'[0-1]'),
                          "+": RegExp(r'[2-9]'),
                          "-": RegExp(r'[2-9]')
                        },
                      ),
                    ],
                    onTextChange: (expire) {
                      _bloc.add(ChangeExpiryEvent(expire));
                    },
                  ),
                ),
                Container(
                  width: getScreenWidth(context) * .37,
                  child: Input(
                    keyboardType: TextInputType.number,
                    placeholder: "CVV",
                    formatter: [
                      MaskTextInputFormatter(
                        mask: '####',
                        filter: {"#": RegExp(r'[0-9]')},
                      ),
                    ],
                    key: Key("cvv"),
                    focusNode: _focusNode,
                    onTextChange: (cvv) {
                      _bloc.add(ChangeCvvEvent(cvv));
                    },
                  ),
                ),
              ],
            ),
            Input(
              key: Key("holderName"),
              placeholder: "Card Holder Name",
              keyboardType: TextInputType.text,
              onTextChange: (holderName) {
                _bloc.add(ChangeCardHolderEvent(holderName.toUpperCase()));
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "CANCEL",
            style: TextStyle(fontSize: 17),
          ),
        ),
        FlatButton(
          onPressed: () {},
          child: Text(
            "SAVE",
            style: TextStyle(color: Colors.blue, fontSize: 17),
          ),
        ),
      ],
    );

    /*return Center(
      child: SingleChildScrollView(
        child:  Wrap(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              width: getScreenWidth(context) * .9,
              child: Column(
                children: <Widget>[
                  BlocBuilder<CreditCardBloc, CreditCardState>(
                    bloc: _bloc,
                    builder: (BuildContext context, CreditCardState state) {
                      return CreditCardWidget(
                        width: getScreenWidth(context) * .9,
                        cardNumber: state.cardNumber,
                        expiryDate: state.expiryDate,
                        cardHolderName: state.cardHolderName,
                        cvvCode: state.cvvCode,
                        showBackView: state.isCvvFocused,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Input(
                          key: Key("cardNumber"),
                          placeholder: "Card Number",
                          keyboardType: TextInputType.number,
                          formatter: [
                            MaskTextInputFormatter(
                              mask: '#### #### #### ####',
                              filter: {"#": RegExp(r'[0-9]')},
                            ),
                          ],
                          onTextChange: (cardNumber) {
                            _bloc.add(ChangeCardNumberEvent(cardNumber));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: getScreenWidth(context) * .37,
                              child: Input(
                                key: Key("expire"),
                                placeholder: "Expire date",
                                keyboardType: TextInputType.number,
                                formatter: [
                                  MaskTextInputFormatter(
                                    mask: '*#/+-',
                                    filter: {
                                      "#": RegExp(r'[0-2]'),
                                      "*": RegExp(r'[0-1]'),
                                      "+": RegExp(r'[2-9]'),
                                      "-": RegExp(r'[2-9]')
                                    },
                                  ),
                                ],
                                onTextChange: (expire) {
                                  _bloc.add(ChangeExpiryEvent(expire));
                                },
                              ),
                            ),
                            Container(
                              width: getScreenWidth(context) * .37,
                              child: Input(
                                keyboardType: TextInputType.number,
                                placeholder: "CVV",
                                formatter: [
                                  MaskTextInputFormatter(
                                    mask: '####',
                                    filter: {"#": RegExp(r'[0-9]')},
                                  ),
                                ],
                                key: Key("cvv"),
                                focusNode: _focusNode,
                                onTextChange: (cvv) {
                                  _bloc.add(ChangeCvvEvent(cvv));
                                },
                              ),
                            ),
                          ],
                        ),
                        Input(
                          key: Key("holderName"),
                          placeholder: "Card Holder Name",
                          keyboardType: TextInputType.text,
                          onTextChange: (holderName) {
                            _bloc.add(ChangeCardHolderEvent(holderName.toUpperCase()));
                          },
                        ),
                        separatorV(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "CANCEL",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                "SAVE",
                                style: TextStyle(color: Colors.blue, fontSize: 17),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );*/
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
