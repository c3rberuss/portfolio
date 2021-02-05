import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/application/application_bloc.dart';
import 'package:services/src/blocs/application/application_event.dart';
import 'package:services/src/models/application_detail.dart';
import 'package:services/src/models/service_model.dart';
import 'package:services/src/presentation/widgets/card.dart';
import 'package:services/src/presentation/widgets/service_dialog.dart';

class Service extends StatelessWidget {
  final ServiceModel service;

  Service(this.service);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Wrap(
        children: <Widget>[
          CustomCard(
            content: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl: service.image,
                      placeholder: (ctx, url) {
                        return CircularProgressIndicator();
                      },
                      errorWidget: (ctx, url, error) {
                        return Icon(
                          Icons.broken_image,
                          color: Colors.blue,
                          size: 40,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    service.title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  Text(
                    service.description,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Chip(
                        backgroundColor: Colors.blue,
                        label: Text(
                          '\$${service.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 30,
                        ),
                        onPressed: () {
                          final _service = ApplicationDetail((d) => d
                            ..title = service.title
                            ..selected = false
                            ..description = service.description
                            ..serviceId = service.serviceId
                            ..workforce = service.workforce
                            ..price = service.price);

                          BlocProvider.of<ApplicationBloc>(context).add(AddServiceEvent(_service));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return ServiceDialog(service);
            });
      },
    );
  }
}
