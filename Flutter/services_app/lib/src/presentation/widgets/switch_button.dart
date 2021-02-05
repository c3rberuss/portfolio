import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({Key key, this.onClick, this.total}) : super(key: key);

  final Function onClick;
  final double total;

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  IconData icon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    icon = FontAwesomeIcons.arrowDown;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: () {
        setState(() {
          icon = icon == FontAwesomeIcons.arrowDown
              ? FontAwesomeIcons.arrowUp
              : FontAwesomeIcons.arrowDown;
        });
        widget.onClick();
      },
      icon: Icon(icon),
      label: Text("\$${widget.total.toStringAsFixed(2)}"),
    );
  }
}
