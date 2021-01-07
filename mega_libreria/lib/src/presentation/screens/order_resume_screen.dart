import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:megalibreria/src/blocs/order/bloc.dart';
import 'package:megalibreria/src/presentation/widgets/custom_app_bar.dart';
import 'package:megalibreria/src/presentation/widgets/dialog.dart';
import 'package:megalibreria/src/presentation/widgets/finish_order_bottom_sheet.dart';
import 'package:megalibreria/src/presentation/widgets/list_items_order.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/utils/functions.dart';
import 'package:megalibreria/src/utils/screen_utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OrderResumeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    if (BlocProvider.of<OrderBloc>(context).state.detail.isNotEmpty) {
      BlocProvider.of<OrderBloc>(context).add(GetFaresEvent());
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "Resúmen de su orden",
        showSearchButton: false,
        showCart: false,
      ),
      body: ListItemsOrder(),
      bottomNavigationBar: BlocConsumer<OrderBloc, OrderState>(
        listener: (BuildContext context, OrderState state) async {
          if (state.noInternet) {
            /* noInternetConnection(context, () {
              _progressDialog.hide();
            });*/
          }

          if (state.sending) {
            //_progressDialog.show();
          }

          if (state.success) {

            await showSuccess(context, "Se orden fue enviada exitosamente");
            //Navigator.pop(context, true);
            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          }

          if (state.error) {
            showError(context, "Error al enviar su orden");
          }
        },
        builder: (BuildContext context, OrderState state) {
          if (state.detail.isEmpty) {
            return SizedBox();
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //Divider(color: _theme.palette.dark.withOpacity(0.7)),
/*                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal", style: TextStyle(fontSize: 18)),
                    Text("\$${state.subtotal.toStringAsFixed(2)}", style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Costo de envío", style: TextStyle(fontSize: 18)),
                    Text("\$${state.fare.fare.toStringAsFixed(2)}", style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total", style: TextStyle(fontSize: 18)),
                    Text("\$${(state.subtotal + state.fare.fare).toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 18)),
                  ],
                ),*/
                SizedBox(
                  width: screenWidth(context),
                  height: screenHeight(context) * 0.1,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
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
                              AutoSizeText(
                                "\$${state.subtotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AutoSizeText("SUB TOTAL"),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                "\$${state.fare.fare.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AutoSizeText("ENVÍO"),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                "\$${(state.fare.fare + state.subtotal).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AutoSizeText("TOTAL"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(color: _theme.palette.dark.withOpacity(0.7)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GFButton(
                      icon: Icon(Icons.clear_all),
                      text: "CANCELAR ORDEN",
                      type: GFButtonType.outline,
                      onPressed: () {
                        BlocProvider.of<OrderBloc>(context).add(ClearOrderEvent());
                      },
                    ),
                    GFButton(
                      text: state.fare.minimum >= 0 && state.subtotal >= state.fare.minimum
                          ? "REALIZAR MI ORDER"
                          : "MONTO MÍNIMO - \$${state.fare.minimum.toStringAsFixed(2)}",
                      icon: Icon(Icons.subdirectory_arrow_right, color: _theme.palette.white),
                      onPressed: !state.fetchingFares ? () async {
                        if (state.fare.minimum >= 0 && state.subtotal >= state.fare.minimum) {
                          showMaterialModalBottomSheet(
                            context: context,
                            bounce: true,
                            backgroundColor: _theme.palette.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                            builder: (ctx, controller) {
                              return FinishOrderBottomSheet(_theme);
                            },
                          );

                          //Navigator.pushNamed(context, "finish");
                        } else {
                          showMessage(
                            context,
                            "El monto mínimo para realizar una compra desde la"
                                " aplicación es de \$${state.fare.minimum.toStringAsFixed(2)}",
                            "Mínimo de compra",
                            DialogType.Info,
                          );
                        }
                      }: null,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
