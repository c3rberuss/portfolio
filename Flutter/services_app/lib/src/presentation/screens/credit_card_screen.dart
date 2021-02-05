import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:services/src/blocs/credit_card/credit_card_bloc.dart';
import 'package:services/src/blocs/credit_card/credit_card_event.dart';
import 'package:services/src/blocs/credit_card/credit_card_state.dart';
import 'package:services/src/presentation/widgets/input.dart';
import 'package:services/src/presentation/widgets/separators.dart';
import 'package:services/src/utils/functions.dart';
import 'package:services/src/utils/screen_utils.dart';

class CreditCardScreen extends StatefulWidget {
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  CreditCardBloc _bloc;
  FocusNode _focusNodeCardNumber;
  FocusNode _focusNodeExpiry;
  FocusNode _focusNodeCvv;
  FocusNode _focusNodeCardHolder;
  TextStyle textStyle;
  MaskedTextController cardNumberController;
  TextEditingController cardHolderController;
  MaskedTextController cardCvvController;
  MaskedTextController cardExpiryDateController;

  @override
  void initState() {
    super.initState();

    _bloc = CreditCardBloc();
    _focusNodeCardNumber = FocusNode();
    _focusNodeExpiry = FocusNode();
    _focusNodeCvv = FocusNode();
    _focusNodeCardHolder = FocusNode();
    textStyle = TextStyle(fontSize: 18, color: Colors.black45);

    _focusNodeCvv.addListener(() {
      _bloc.add(CvvFocusedEvent(_focusNodeCvv.hasFocus));
    });

    cardNumberController = MaskedTextController(
      mask: '#### #### #### ####',
      translator: {"#": RegExp(r'[0-9]')},
    );
    cardHolderController = TextEditingController();
    cardCvvController = MaskedTextController(
      mask: '####',
      translator: {"#": RegExp(r'[0-9]')},
    );
    cardExpiryDateController = MaskedTextController(
      mask: '##/##',
      translator: {
        "#": RegExp(r'[0-9]'),
      },
    );

    cardNumberController.addListener(() {});

    cardExpiryDateController.addListener(() {});

    cardCvvController.addListener(() {});

    cardHolderController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreditCardBloc, CreditCardState>(
      bloc: _bloc,
      listener: (BuildContext context, CreditCardState state) {
        if (state.saveCard) {
          Navigator.pop(context, state.card);
        }
      },
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Payment info"),
            actions: <Widget>[
              BlocBuilder<CreditCardBloc, CreditCardState>(
                bloc: _bloc,
                builder: (BuildContext context, CreditCardState state) {
                  if (state.isValidCard) {
                    return IconButton(
                      onPressed: () {
                        _bloc.add(SaveCreditCardEvent());
                      },
                      icon: Icon(FontAwesomeIcons.check),
                    );
                  }
                  return Container(height: 0, width: 0);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<CreditCardBloc, CreditCardState>(
              bloc: _bloc,
              builder: (BuildContext context, CreditCardState state) {
                return Column(
                  children: <Widget>[
                    CreditCardWidget(
                      cardNumber: state.cardNumber,
                      expiryDate: state.expiryDate,
                      cardHolderName: state.cardHolderName,
                      cvvCode: state.cvvCode,
                      showBackView: state.isCvvFocused,
                      cardBgColor: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(" Card number", style: textStyle),
                          Input(
                            key: Key("cardNumber"),
                            placeholder: "1234 5678 9012 3456",
                            keyboardType: TextInputType.number,
                            action: TextInputAction.next,
                            showSuffix: true,
                            isValid: state.isValidCardNumber,
                            controller: cardNumberController,
                            focusNode: _focusNodeCardNumber,
                            onAction: () {
                              fieldFocusChange(context, _focusNodeCardNumber, _focusNodeExpiry);
                            },
                            onTextChange: (cardNumber) {
                              _bloc.add(ChangeCardNumberEvent(cardNumberController.text));
                            },
                          ),
                          separatorV(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: getScreenWidth(context) * .46,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(" Exp. date", style: textStyle),
                                    Input(
                                      key: Key("expire"),
                                      placeholder: "09/24",
                                      keyboardType: TextInputType.number,
                                      action: TextInputAction.next,
                                      showSuffix: true,
                                      isValid: state.isValidExpiryDate,
                                      controller: cardExpiryDateController,
                                      focusNode: _focusNodeExpiry,
                                      onAction: () {
                                        fieldFocusChange(context, _focusNodeExpiry, _focusNodeCvv);
                                      },
                                      onTextChange: (exp) {
                                        _bloc.add(ChangeExpiryEvent(cardExpiryDateController.text));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: getScreenWidth(context) * .46,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(" CVV", style: textStyle),
                                    Input(
                                      keyboardType: TextInputType.number,
                                      placeholder: "123",
                                      key: Key("cvv"),
                                      focusNode: _focusNodeCvv,
                                      action: TextInputAction.next,
                                      showSuffix: true,
                                      isValid: state.isValidCvv,
                                      controller: cardCvvController,
                                      onAction: () {
                                        fieldFocusChange(
                                            context, _focusNodeCvv, _focusNodeCardHolder);
                                      },
                                      onTextChange: (cvv) {
                                        _bloc.add(ChangeCvvEvent(cardCvvController.text));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          separatorV(10),
                          Text(" Card holder name", style: textStyle),
                          Input(
                            key: Key("holderName"),
                            placeholder: "Carl Smith",
                            keyboardType: TextInputType.text,
                            action: TextInputAction.done,
                            focusNode: _focusNodeCardHolder,
                            showSuffix: true,
                            isValid: state.isValidCardHolder,
                            controller: cardHolderController,
                            onAction: () {
                              fieldFocusChange(context, _focusNodeCardHolder);
                            },
                            onTextChange: (name) {
                              _bloc.add(
                                  ChangeCardHolderEvent(cardHolderController.text.toUpperCase()));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        onWillPop: () {
          return Future.value(true);
        },
      ),
    );
  }
}
