import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookshop/src/blocs/order/bloc.dart';
import 'package:bookshop/src/models/products/product_model.dart';
import 'package:bookshop/src/models/products/product_type.dart';
import 'package:bookshop/src/presentation/widgets/qty_selector.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';

import 'header.dart';

class AddProductBottomSheet extends StatefulWidget {
  final ProductModel data;
  final Function onSuccess;

  AddProductBottomSheet(this.data, {this.onSuccess});

  @override
  _AddProductBottomSheetState createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  final _textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w300);
  double subtotal;
  int qty;

  @override
  void initState() {
    super.initState();

    subtotal = widget.data.type == ProductType.virtual
        ? widget.data.price
        : (widget.data.stock > 0 ? widget.data.price : 0);

    qty = widget.data.type == ProductType.virtual
        ? 1
        : widget.data.stock > 0
            ? 1
            : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          width: screenWidth(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 8,
                        width: screenWidth(context) * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(62),
                          color: GFColors.PRIMARY,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight(context) * 0.03),
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: widget.data.image,
                        width: constraints.biggest.width * 0.3,
                        height: constraints.biggest.width * 0.3,
                        fit: BoxFit.cover,
                        placeholder: (ctx, url) {
                          return Container(
                            width: constraints.biggest.width * 0.3,
                            height: constraints.biggest.width * 0.3,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorWidget: (ctx, url, _) {
                          return Center(
                            child: ClipRRect(
                              child: Image.asset(
                                "assets/images/no_image.jpg",
                                width: constraints.biggest.width * 0.3,
                                height: constraints.biggest.width * 0.3,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight(context) * 0.03),
                    Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        widget.data.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: GFColors.PRIMARY,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Divider(),
                    Header(text: "Descripción"),
                    Divider(),
                    SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(widget.data.description),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight(context) * 0.03),
                    Header(text: "Resúmen"),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (widget.data.type == ProductType.physical) ...[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AutoSizeText("Stock", style: _textStyle),
                                SizedBox(height: 5),
                                Text(
                                  "${widget.data.stock}",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: GFColors.PRIMARY,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Subtotal", style: _textStyle),
                              SizedBox(height: 5),
                              AutoSizeText(
                                "\$${subtotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Cantidad", style: _textStyle),
                              SizedBox(height: 5),
                              QtySelector(
                                maxQty: widget.data.stock,
                                withoutLimit: widget.data.type == ProductType.virtual,
                                qtyChange: (qty) {
                                  print(qty);
                                  setState(() {
                                    this.qty = qty;
                                    subtotal = (this.qty * widget.data.price) * 1.0;
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight(context) * 0.02),
                    GFButton(
                      text: "Agregar",
                      icon: Icon(Icons.add_shopping_cart, color: GFColors.WHITE),
                      blockButton: true,
                      onPressed: widget.data.stock > 0 || widget.data.type == ProductType.virtual
                          ? () {
                              BlocProvider.of<OrderBloc>(context)
                                  .add(AddOrderItemEvent(widget.data, qty));

                              if (widget.onSuccess != null) {
                                widget.onSuccess();
                              }

                              Navigator.pop(context);
                            }
                          : null,
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
