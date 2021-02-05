import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/application/application_bloc.dart';
import 'package:services/src/blocs/application/application_event.dart';
import 'package:services/src/blocs/application/application_state.dart';
import 'package:services/src/models/application_detail.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({Key key, @required this.service, this.pos, this.withBloc = true})
      : super(key: key);
  final ApplicationDetail service;
  final int pos;
  final bool withBloc;

  @override
  Widget build(BuildContext context) {
    if (withBloc) {
      return BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (BuildContext context, ApplicationState state) {
          return ListTile(
            leading: Checkbox(
              value: service.selected,
              onChanged: (value) {
                //provider.select(pos, value);
                BlocProvider.of<ApplicationBloc>(context).add(SelectServiceEvent(value, pos));
              },
            ),
            title: Text(service.title),
            subtitle: Text(service.description),
            onTap: () {
              BlocProvider.of<ApplicationBloc>(context)
                  .add(ShowOrHideBottomSheet(forceClose: true));
            },
          );
        },
      );
    }

    return ListTile(
      title: Text(service.title),
      subtitle: Text(service.description),
    );
  }
}
