import 'package:flutter/material.dart';
import 'package:services/app/styles/palette.dart';

class PriceWidget extends StatelessWidget {
  final TextStyle _decimalStyle = TextStyle(
    color: Palette.primary,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _integersStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: Palette.primary,
  );

  final double amount;

  PriceWidget(this.amount);

  @override
  Widget build(BuildContext context) {
    _integers();
    _decimals();

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("\$${_integers()}.", style: _integersStyle),
          Column(
            children: [
              SizedBox(height: 3),
              Text(
                _decimals(),
                style: _decimalStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

  String _integers() {
    return this.amount.toStringAsFixed(2).split(".")[0];
  }

  String _decimals() {
    return this.amount.toStringAsFixed(2).split(".")[1];
  }
}
