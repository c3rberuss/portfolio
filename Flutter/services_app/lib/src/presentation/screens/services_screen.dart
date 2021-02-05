import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:services/src/blocs/application/bloc.dart';
import 'package:services/src/blocs/services/bloc.dart';
import 'package:services/src/blocs/services/services_bloc.dart';
import 'package:services/src/models/service_model.dart';
import 'package:services/src/presentation/widgets/dialog.dart';
import 'package:services/src/presentation/widgets/service.dart';
import 'package:services/src/utils/functions.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({Key key, @required this.categoryId}) : super(key: key);

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _bloc = BlocProvider.of<ServicesBloc>(context);

    return Scaffold(
      appBar: AppBar(),
      body: MultiBlocListener(
          listeners: [
            BlocListener<ApplicationBloc, ApplicationState>(
              listener: (BuildContext context, ApplicationState state) {
                if (state.serviceAdded) {
                  showMessage(context, "Service Added", DialogType.Success, "Services");
                } else if (state.existsService) {
                  showMessage(context, "This service already added", DialogType.Info, "Services");
                }
              },
            ),
            BlocListener<ServicesBloc, ServicesState>(
              listener: (BuildContext context, ServicesState state) {
                if (state is RefreshServicesCompleted) {
                  _refreshController.refreshCompleted();
                }
              },
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Services",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Divider(),
              Expanded(
                child: BlocBuilder<ServicesBloc, ServicesState>(
                  builder: (BuildContext context, state) {
                    if (state is ServicesObtainedState) {
                      return _buildBody(
                        child: _buildServices(state.services),
                        bloc: _bloc,
                        categoryId: categoryId,
                      );
                    } else if (state is LoadingServicesState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is EmptyServicesState) {
                      return _buildBody(
                        child: Center(child: Text(state.message)),
                        bloc: _bloc,
                        categoryId: categoryId,
                      );
                    }

                    return null;
                  },
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildBody(
      {@required Widget child, @required ServicesBloc bloc, @required int categoryId}) {
    return SmartRefresher(
      header: WaterDropHeader(waterDropColor: Colors.blue),
      onRefresh: () {
        bloc.add(RefreshServicesEvent(categoryId));
      },
      controller: _refreshController,
      child: child,
    );
  }

  Widget _buildServices(BuiltList<ServiceModel> services) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        //childAspectRatio: 0.98,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      padding: EdgeInsets.all(8),
      itemCount: services.length,
      itemBuilder: (ctx, index) {
        return Service(services[index]);
      },
    );
  }
}
