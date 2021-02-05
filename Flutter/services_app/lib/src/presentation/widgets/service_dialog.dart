import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:services/src/models/service_model.dart';
import 'package:services/src/utils/screen_utils.dart';

class ServiceDialog extends StatelessWidget {
  final ServiceModel service;

  ServiceDialog(this.service);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(service.title),
      content: Wrap(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: service.image,
                width: getScreenWidth(context) * .8,
                height: getScreenWidth(context) * .5,
              ),
              Divider(
                height: getScreenHeight(context) * .05,
              ),
              SingleChildScrollView(
                child: Text(service.description),
              ),
              Divider(
                height: getScreenHeight(context) * .05,
              ),
              Table(
                children: [
                  TableRow(children: [
                    Text(
                      "Price",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Workfoce",
                      textAlign: TextAlign.center,
                    ),
                  ]),
                  TableRow(children: [
                    Chip(
                      label: Text(
                        "\$${service.price.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.blueAccent,
                    ),
                    Chip(
                      label: Text(
                        "\$${service.workforce.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.blueAccent,
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("CLOSE"),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
