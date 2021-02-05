import 'package:bookshop/src/models/orders/order_state_model.dart';
import 'package:bookshop/src/utils/datetime.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class RecordItem extends StatelessWidget {
  final OrderStateModel data;

  RecordItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                data.state,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.withOpacity(0.9),
                ),
              ),
              Divider(),
              if (data.comment.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data.comment,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight(context) * 0.03)
              ],
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatDatetime(data.date, data.time),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
              )
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 
                  Text("a las ${HM(data.time)}"),
                ],
              ),*/
            ],
          ),
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
