import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:services/src/blocs/categories/bloc.dart';
import 'package:services/src/blocs/categories/categories_bloc.dart';
import 'package:services/src/blocs/categories/categories_state.dart';
import 'package:services/src/blocs/notifications/notifications_bloc.dart';
import 'package:services/src/blocs/notifications/notifications_state.dart';
import 'package:services/src/models/category_model.dart';
import 'package:services/src/presentation/widgets/category.dart';
import 'package:services/src/presentation/widgets/drawer.dart';
import 'package:services/src/presentation/widgets/notification_dialog.dart';
import 'package:services/src/presentation/widgets/shopping.dart';
import 'package:services/src/utils/notifications.dart';

class HomeScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final Notifications _notifications = Notifications();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _bloc = BlocProvider.of<CategoriesBloc>(context);

    _notifications.setupNotifications(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<CategoriesBloc, CategoriesState>(
            listener: (BuildContext context, CategoriesState state) {
          if (state is RefreshDataCompleteState) {
            _refreshController.refreshCompleted();
          }
        }),
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (BuildContext context, NotificationsState state) {
            if (state is ShowNotification) {
              showDialog(
                context: context,
                barrierDismissible: false,
                // false = user must tap button, true = tap outside dialog
                builder: (BuildContext dialogContext) {
                  return NotificationDialog(
                    type: state.body.data.notificationType,
                    origin: state.origin,
                    notification: state.body.notification,
                    data: state.body.data,
                  );
                },
              );
            }
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Tires Services'),
          actions: <Widget>[
            ShoppingCart(),
          ],
        ),
        drawer: CustomDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Divider(),
            Expanded(
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is DataObtainedState) {
                    return _buildBody(child: _buildCategories(state.categories), bloc: _bloc);
                  } else if (state is EmptyDataState) {
                    return _buildBody(
                        child: Center(child: Text("Categories not found :(")), bloc: _bloc);
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody({@required Widget child, @required CategoriesBloc bloc}) {
    return SmartRefresher(
      header: WaterDropHeader(waterDropColor: Colors.blue),
      onRefresh: () {
        bloc.add(RefreshDataEvent());
      },
      controller: _refreshController,
      child: child,
    );
  }

  Widget _buildCategories(BuiltList<CategoryModel> categories) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
      padding: EdgeInsets.all(8),
      itemCount: categories.length,
      itemBuilder: (ctx, index) {
        return Category(
          title: categories[index].title,
          imagePath: categories[index].image,
          categoryId: categories[index].idCatalog,
        );
      },
    );
  }
}
