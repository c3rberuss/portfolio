import 'package:app/app/styles/palette.dart';
import 'package:flutter/material.dart';

class QtySelector extends StatefulWidget {
  final Function(int) qtyChange;
  final int maxQty;
  final bool withoutLimit;

  QtySelector({@required this.qtyChange, @required this.maxQty, this.withoutLimit = false});

  @override
  _QtySelectorState createState() => _QtySelectorState();
}

class _QtySelectorState extends State<QtySelector> {
  int qty;

  @override
  void initState() {
    super.initState();
    qty = widget.withoutLimit
        ? 1
        : widget.maxQty > 0
            ? 1
            : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              onTap: subQty,
              borderRadius: BorderRadius.circular(10),
              onLongPress: () {
                setState(() {
                  qty = 1;
                });

                widget.qtyChange(qty);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    top: BorderSide(color: Palette.dark),
                    right: BorderSide(color: Palette.dark),
                    bottom: BorderSide(color: Palette.dark),
                    left: BorderSide(color: Palette.dark),
                  ),
                ),
                child: Icon(Icons.remove, size: 32),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
              child: Text(
                qty < 10 ? "0" + qty.toString() : qty.toString(),
                style: TextStyle(
                  fontSize: 24,
                  color: Palette.dark.withOpacity(0.7),
                ),
              ),
            ),
            InkWell(
              onTap: addQty,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    top: BorderSide(color: Palette.dark),
                    right: BorderSide(color: Palette.dark),
                    bottom: BorderSide(color: Palette.dark),
                    left: BorderSide(color: Palette.dark),
                  ),
                ),
                child: Icon(Icons.add, size: 32),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addQty() {
    if (qty < widget.maxQty || widget.withoutLimit) {
      setState(() {
        qty++;
      });

      widget.qtyChange(qty);
    }
  }

  void subQty() {
    if (qty > 1) {
      setState(() {
        qty--;
      });
      widget.qtyChange(qty);
    }
  }
}
