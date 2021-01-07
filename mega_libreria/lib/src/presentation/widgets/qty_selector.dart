import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

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
    qty = widget.withoutLimit ? 1 : widget.maxQty > 0 ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {

    return Wrap(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border(
                top: BorderSide(color: GFColors.PRIMARY),
                right: BorderSide(color: GFColors.PRIMARY),
                bottom: BorderSide(color: GFColors.PRIMARY),
                left: BorderSide(color: GFColors.PRIMARY),
              )
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: subQty,
                onLongPress: (){
                  setState(() {
                    qty = 1;
                  });

                  widget.qtyChange(qty);
                },
                child: Container(
                  decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(4),
                      border: Border(
                      top: BorderSide.none,//BorderSide(color: GFColors.PRIMARY),
                      right: BorderSide(color: GFColors.PRIMARY),
                      bottom: BorderSide.none,//BorderSide(color: GFColors.PRIMARY),
                      left: BorderSide.none,//BorderSide(color: GFColors.PRIMARY),
                    )
                  ),
                  child: Icon(Icons.remove, size: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
                child: Text(
                  qty < 10 ? "0"+qty.toString() : qty.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    color: GFColors.DARK.withOpacity(0.7),
                  ),
                ),
              ),
              InkWell(
                onTap: addQty,
                child: Container(
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(4),
                      border: Border(
                        top: BorderSide.none,//BorderSide(color: GFColors.PRIMARY),
                        right: BorderSide.none,//BorderSide(color: GFColors.PRIMARY),
                        bottom: BorderSide.none,//BorderSide(color: GFColors.PRIMARY),
                        left: BorderSide(color: GFColors.PRIMARY),
                      )
                  ),
                  child: Icon(Icons.add, size: 32),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addQty() {
    if(qty < widget.maxQty || widget.withoutLimit){
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

