import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:services/src/models/application_model.dart';
import 'package:services/src/models/application_status_model.dart';
import 'package:services/src/utils/screen_utils.dart';

class ApplicationTile extends StatelessWidget {
  const ApplicationTile({Key key, this.application, @required this.callback}) : super(key: key);

  final ApplicationModel application;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('dd/MM/y');

    return InkWell(
      onTap: this.callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: getScreenWidth(context) * .20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (application.status == ApplicationStatusModel.paid) ...[
                    Icon(FontAwesomeIcons.check, color: Colors.green),
                    Text('Paid')
                  ] else if (application.status == ApplicationStatusModel.unpaid) ...[
                    Icon(FontAwesomeIcons.exclamationCircle, color: Colors.orange),
                    Text('Unpaid')
                  ] else if (application.status == ApplicationStatusModel.partialPaid) ...[
                    Icon(FontAwesomeIcons.infoCircle, color: Colors.yellow),
                    Text('Partial Paid')
                  ] else if (application.status == ApplicationStatusModel.cancelled) ...[
                    Icon(FontAwesomeIcons.timesCircle, color: Colors.red),
                    Text('Cancelled')
                  ],
                ],
              ),
            ),
            Text(df.format(DateTime.parse(application.createdAt))),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Chip(label: Text("\$${application.total.toStringAsFixed(2)}")),
                Text("Total"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
