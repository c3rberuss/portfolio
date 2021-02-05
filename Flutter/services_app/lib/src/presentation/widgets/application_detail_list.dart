import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:services/src/models/application_detail.dart';
import 'package:services/src/presentation/widgets/service_tile.dart';

class ApplicationDetailList extends StatelessWidget {
  final BuiltList<ApplicationDetail> services;
  final bool withBloc;

  ApplicationDetailList(this.services, {this.withBloc = true});

  @override
  Widget build(BuildContext context) {
    if (services.length > 0) {
      return ListView.builder(
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          return ServiceTile(
            service: services[index],
            pos: index,
            withBloc: withBloc,
          );
        },
      );
    }

    return Center(
      child: Text("Nothing here :("),
    );
  }
}
