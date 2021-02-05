import 'package:bookshop/src/blocs/order/bloc.dart';
import 'package:bookshop/src/blocs/order/finish_order_bloc_form.dart';
import 'package:bookshop/src/blocs/products/bloc.dart';
import 'package:bookshop/src/blocs/profile/bloc.dart';
import 'package:bookshop/src/models/orders/card_model.dart';
import 'package:bookshop/src/models/response/response_form_clasess.dart';
import 'package:bookshop/src/presentation/widgets/credit_card_dialog.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:bookshop/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class FinishOrderBottomSheet extends StatelessWidget {
  final ThemeRepository _theme;

  FinishOrderBottomSheet(this._theme);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState profileState) {
        return BlocProvider(
          create: (context) => FinishOrderBlocForm(
            context.repository<UserRepository>(),
            profileState.user,
          ),
          child: Builder(
            builder: (BuildContext context) {
              final bloc = context.bloc<FinishOrderBlocForm>();

              return FormBlocListener<FinishOrderBlocForm, String, FailResponse<ErrorType>>(
                formBloc: bloc,
                child: Wrap(
                  children: <Widget>[
                    Container(
                      width: screenWidth(context),
                      //height: screenHeight(context) * 0.95,
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 8,
                                width: screenWidth(context) * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: _theme.palette.primary,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight(context) * 0.035),
                            RadioButtonGroupFieldBlocBuilder<String>(
                              selectFieldBloc: bloc.serviceType,
                              canDeselect: false,
                              itemBuilder: (context, item) {
                                return item;
                              },
                              decoration:
                                  Styles.inputDecorator(_theme.palette, label: "Tipo de servicio"),
                            ),
                            CustomDialogFormBlocBuilder<String>(
                              inputFieldBloc: bloc.address,
                              animateWhenCanShow: true,
                              decoration: Styles.inputDecorator(
                                _theme.palette,
                                label: "Dirección",
                                prefix: FontAwesomeIcons.mapMarkerAlt,
                              ),
                              showSelected: (item) {
                                if (profileState.user.address.isNotEmpty) {
                                  bloc.address.updateValue(profileState.user.address);
                                }

                                return item != null ? item : "";
                              },
                              getValueFromDialog: () async {
                                await Navigator.pushNamed(context, "/profile", arguments: true);
                                return null;
                              },
                            ),
                            CustomDialogFormBlocBuilder<String>(
                              inputFieldBloc: bloc.branch,
                              animateWhenCanShow: true,
                              decoration: Styles.inputDecorator(
                                _theme.palette,
                                label: "Sucursal",
                                prefix: FontAwesomeIcons.warehouse,
                              ),
                              showSelected: (item) {
                                return item != null ? item : "";
                              },
                              getValueFromDialog: () async {
                                final response = await showDialog(
                                  context: context,
                                  child: CreditCardDialog(),
                                );

                                return response;
                              },
                            ),
                            RadioButtonGroupFieldBlocBuilder<String>(
                              selectFieldBloc: bloc.paymentType,
                              canDeselect: false,
                              itemBuilder: (context, item) {
                                return item;
                              },
                              decoration:
                                  Styles.inputDecorator(_theme.palette, label: "Tipo de pago"),
                            ),
                            RadioButtonGroupFieldBlocBuilder<String>(
                              selectFieldBloc: bloc.requireChange,
                              canDeselect: false,
                              itemBuilder: (context, item) {
                                return item;
                              },
                              decoration:
                                  Styles.inputDecorator(_theme.palette, label: "¿Necesita cambio?"),
                            ),
                            CustomDialogFormBlocBuilder<CardModel>(
                              inputFieldBloc: bloc.creditCard,
                              animateWhenCanShow: true,
                              decoration: Styles.inputDecorator(_theme.palette,
                                  label: "Tarjeta de crédito/débito",
                                  prefix: FontAwesomeIcons.solidCreditCard),
                              showSelected: (item) {
                                return item != null ? item.number : "";
                              },
                              getValueFromDialog: () async {
                                final response = await showDialog(
                                  context: context,
                                  child: CreditCardDialog(),
                                );

                                return response;
                              },
                            ),
                            DropdownFieldBlocBuilder(
                              selectFieldBloc: bloc.changeOf,
                              itemBuilder: (context, item) {
                                return item;
                              },
                              showEmptyItem: false,
                              decoration: Styles.inputDecorator(
                                _theme.palette,
                                label: "Cambio de",
                                prefix: FontAwesomeIcons.solidMoneyBillAlt,
                              ),
                            ),
/*                        Text(
                          "RESUMEN",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),*/
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              child: BlocBuilder<OrderBloc, OrderState>(
                                builder: (BuildContext context, OrderState state) {
                                  return Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(color: _theme.palette.primary, width: 0.5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "\$${state.subtotal.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text("SUB TOTAL"),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "\$${state.fare.fare.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text("ENVÍO"),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "\$${(state.fare.fare + state.subtotal).toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text("TOTAL"),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: screenHeight(context) * 0.01),
                            Align(
                              alignment: Alignment.center,
                              child: GFButton(
                                color: _theme.palette.primary,
                                splashColor: _theme.palette.secondary.withOpacity(0.3),
                                disabledColor: Colors.grey.withOpacity(0.8),
                                shape: GFButtonShape.standard,
                                type: GFButtonType.solid,
                                blockButton: true,
                                text: "FINALIZAR ORDEN",
                                onPressed: () {
                                  BlocProvider.of<ProductsBloc>(context)
                                      .add(ClearProductsStateEvent());
                                },
                              ),
                            )
                            /*BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (BuildContext context, ProfileState state) {
                    return Column(
                      children: <Widget>[
                        Text(
                          "DIRECCIÓN DE ENTREGA",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.01),
                        SizedBox(
                          width: screenWidth(context),
                          height: screenHeight(context) * 0.1,
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: _theme.palette.primary, width: 0.5),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final address = await Navigator.pushNamed(context, "pick_address");

                                if (address != null && address is AddressModel) {
                                  BlocProvider.of<OrderBloc>(context)
                                      .add(ChangeAddressEvent(address));
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      child: Text(
                                        state.user.address == null
                                            ? "Selecccionar"
                                            : "${state.user.address}, "
                                            "${state.user.city.name}, "
                                            "${state.user.department.name}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      width: screenWidth(context) * 0.75,
                                    ),
                                    Icon(
                                      state.user.address == null
                                          ? Icons.remove_circle
                                          : Icons.check_circle,
                                      color: _theme.palette.primary,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.03),
                      ],
                    );
                  },
                ),
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (BuildContext context, OrderState state) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "MÉTODO DE PAGO",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: screenWidth(context) * 0.45,
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: _theme.palette.primary, width: 0.5),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    BlocProvider.of<OrderBloc>(context)
                                        .add(ChangePaymentTypeEvent(PaymentType.cash));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.monetization_on,
                                          textDirection: TextDirection.ltr,
                                          size: 35,
                                          color: state.paymentType == PaymentType.cash
                                              ? _theme.palette.primary
                                              : Colors.grey.withOpacity(0.8),
                                        ),
                                        SizedBox(height: screenHeight(context) * 0.01),
                                        Text("EFECTIVO"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth(context) * 0.01),
                            SizedBox(
                              width: screenWidth(context) * 0.45,
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: _theme.palette.primary, width: 0.5),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showMessage(context, "Se habilitará en próximas versiones",
                                        "Pago con tarjeta", DialogType.Info);
                                    */ /*BlocProvider.of<OrderBloc>(context).add(
                                                    ChangePaymentTypeEvent(PaymentType.creditCard));*/ /*
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.credit_card,
                                          textDirection: TextDirection.ltr,
                                          size: 35,
                                          color: state.paymentType == PaymentType.creditCard
                                              ? _theme.palette.primary
                                              : Colors.grey.withOpacity(0.8),
                                        ),
                                        SizedBox(height: screenHeight(context) * 0.01),
                                        Text("CRÉDITO/DÉBITO"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight(context) * 0.01),
                        SizedBox(
                          width: screenWidth(context),
                          height: screenHeight(context) * 0.1,
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: _theme.palette.primary, width: 0.5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "\$${state.subtotal.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("SUB TOTAL"),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "\$${state.fare.fare.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("ENVÍO"),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "\$${(state.fare.fare + state.subtotal).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("TOTAL"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.03),
                        Align(
                          alignment: Alignment.center,
                          child: GFButton(
                            color: _theme.palette.primary,
                            splashColor: _theme.palette.secondary.withOpacity(0.3),
                            disabledColor: Colors.grey.withOpacity(0.8),
                            shape: GFButtonShape.standard,
                            type: GFButtonType.solid,
                            blockButton: true,
                            text: "FINALIZAR ORDEN",
                            onPressed: state.address == null && state.fare != null
                                ? null
                                : () {
                              BlocProvider.of<ProductsBloc>(context)
                                  .add(ClearProductsStateEvent());
                              */ /*BlocProvider.of<OrderBloc>(context)
                                                        .add(SendOrderEvent());*/ /*
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),*/
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
      },
    );
  }
}
