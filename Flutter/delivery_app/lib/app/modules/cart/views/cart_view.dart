import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/cart/controllers/cart_controller.dart';
import 'package:line_icons/line_icons.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (_) {
              controller.toggleAnimation();
              return true;
            },
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Palette.white,
                  iconTheme: context.theme.iconTheme.copyWith(color: Palette.dark),
                  pinned: true,
                  title: Text(
                    "Mi pedido",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Palette.dark,
                    ),
                  ),
                  centerTitle: true,
                ),
                FutureBuilder(
                  future: Future.delayed(Duration(seconds: 5), () {
                    Future.delayed(Duration(seconds: 2))
                        .then((value) => controller.bottomDetail.value = 0);
                    return true;
                  }),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) {
                            return _CartStore();
                          },
                          childCount: 3,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ObxValue<RxDouble>((bottom) {
            return AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: bottom.value,
              duration: Duration(milliseconds: 200),
              child: _CartInfo(),
            );
          }, controller.bottomDetail),
        ],
      ),
    );
  }
}

class _CartStore extends StatelessWidget {
  final _itemTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  final _itemDataStyle = TextStyle(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Nombre del negocio",
          style: TextStyle(fontSize: 12),
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              //height: 75,
              width: Get.width,
              decoration: Styles.boxDecoration(background: Palette.light),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 55,
                          width: 55,
                          child: Placeholder(),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nombre de producto con mucho más texto",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: _itemTitleStyle,
                              ),
                              Text("\$0.80", style: _itemDataStyle),
                              Text("3x", style: _itemDataStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Icon(LineIcons.pencil),
                        onTap: () {},
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        child: Icon(LineIcons.trash),
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
        Text("Mensaje al vendedor:"),
        Input(
          controller: TextEditingController(),
          hint: "Ej. Deseo curtido de mayonesa",
          prefixIcon: Icon(LineIcons.align_justify),
        ),
        SizedBox(height: 45),
      ],
    );
  }
}

class _CartInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.white,
        boxShadow: [
          BoxShadow(
            color: Palette.grey.withOpacity(0.1),
            offset: Offset(0, -5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Aplicar cupón", style: TextStyle(fontSize: 12)),
          Row(
            children: [
              Expanded(
                child: Input(
                  controller: TextEditingController(),
                  showClear: true,
                  prefixIcon: Icon(LineIcons.comment),
                ),
              ),
              SizedBox(width: 16),
              CustomFillButton(
                text: "Aplicar",
                buttonType: CustomButtonType.dark,
                onPressed: () {},
              )
            ],
          ),
          Divider(
            thickness: 1,
            height: 32,
            color: Palette.dark,
          ),
          _CartDetail(text: "Subtotal:", amount: 3.0),
          _CartDetail(text: "Costo de envío:", amount: 1.75),
          _CartDetail(text: "Descuento:", amount: 0.0),
          _CartDetail(text: "Total a pagar", amount: 4.75, bold: true),
          SizedBox(height: 25),
          CustomFillButton(
            text: "Pago",
            fullWidth: true,
            maxWidth: 500,
            minWidth: 500,
            buttonType: CustomButtonType.success,
            onPressed: () {
              Get.toNamed(Routes.CHECKOUT);
            },
          ),
        ],
      ),
    );
  }
}

class _CartDetail extends StatelessWidget {
  final _textStyle = TextStyle(fontSize: 16);

  final String text;
  final double amount;
  final bool bold;

  _CartDetail({@required this.text, @required this.amount, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: bold ? _textStyle.copyWith(fontWeight: FontWeight.w800) : _textStyle,
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: bold ? _textStyle.copyWith(fontWeight: FontWeight.w800) : _textStyle,
        ),
      ],
    );
  }
}
