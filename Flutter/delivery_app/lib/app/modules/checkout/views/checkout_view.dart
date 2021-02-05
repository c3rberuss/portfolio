import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:line_icons/line_icons.dart';

class CheckoutView extends GetView<CheckoutController> {
  final _textStyle = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.white,
            title: Text(
              "Finalizar pedido",
              style: TextStyle(color: Palette.dark),
            ),
            centerTitle: true,
            iconTheme: context.theme.iconTheme.copyWith(color: Palette.dark),
            pinned: true,
            leading: IconButton(
              icon: Icon(LineIcons.arrow_left),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Action(
                    title: "Dirección",
                    line1: "Casa",
                    line2: "Col. las palmeras, calle tritón, Pol. 11 #18. San Miguel",
                    line3: "Ref. Casa verde",
                    onEdit: () {},
                  ),
                  SizedBox(height: 32),
                  _Action(
                    title: "Información de contacto:",
                    line1: "Edwin Osmin Orellana Martinez",
                    line2: "7581-0898",
                    line3: "edwinho.orellana301@gmail.com",
                    onEdit: () {},
                  ),
                  SizedBox(height: 32),
                  Text("Indicaciones de entrega al conductor: (opcional): "),
                  Input(
                    controller: TextEditingController(),
                    hint: "Ej: Deseo vuelto billete de \$20.00",
                    prefixIcon: Icon(LineIcons.align_justify),
                  ),
                  SizedBox(height: 32),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: Get.width * 0.7,
                      child: Divider(
                        thickness: 1,
                        color: Palette.dark,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Método de pago"),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(LineIcons.money),
                        label: Text("Efectivo"),
                        color: Palette.white,
                        shape: Styles.shapeRounded(),
                      ),
                      FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(LineIcons.money),
                        label: Text("Tarjeta"),
                        color: Palette.dark,
                        shape: Styles.shapeRounded(),
                        textColor: Palette.white,
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total a pagar:",
                        style: _textStyle.copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "\$${4.75.toStringAsFixed(2)}",
                        style: _textStyle.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomFillButton(
                    text: "Confirmar pedido",
                    buttonType: CustomButtonType.success,
                    fullWidth: true,
                    minWidth: 500,
                    maxWidth: 500,
                    onPressed: () {
                      Get.toNamed(Routes.PAYMENT);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final String title;
  final String line1;
  final String line2;
  final String line3;

  final VoidCallback onEdit;

  _Action({
    this.title = "title",
    this.line1 = "Line 1",
    this.line2 = "Line 2",
    this.line3 = "Line 3",
    @required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12),
            ),
            FlatButton.icon(
              onPressed: onEdit,
              icon: Icon(LineIcons.pencil),
              label: Text("Editar"),
              color: Palette.dark,
              textColor: Palette.white,
              shape: Styles.shapeRounded(),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          width: Get.width,
          padding: EdgeInsets.all(16),
          decoration: Styles.boxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                line1,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                line2,
                style: TextStyle(fontSize: 12),
              ),
              Text(
                line3,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
