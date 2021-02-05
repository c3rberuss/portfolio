import 'package:bookshop/src/models/args/order_args.dart';
import 'package:bookshop/src/presentation/widgets/orders_list.dart';
import 'package:bookshop/src/presentation/widgets/records.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserOrderDetail extends StatefulWidget {
  UserOrderDetail();

  @override
  _UserOrderDetailState createState() => _UserOrderDetailState();
}

class _UserOrderDetailState extends State<UserOrderDetail> with SingleTickerProviderStateMixin {
  ThemeRepository _theme;
  OrderArgs data;

  @override
  void initState() {
    super.initState();

    _theme = RepositoryProvider.of<ThemeRepository>(context);
    data = ModalRoute.of(context).settings.arguments;

    if (data.fromNotification) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "tracking/${data.order.orderNumber}");
      });
    }

    if (data.order.status == "ENTREGADA") {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        //final rating = await rateOrder(context);

/*        BlocProvider.of<OrdersUserBloc>(context).add(RateOrderEvent(data.id, rating));

        if (rating > 0) {
          showMessage(context, "Tu opinión es importante para brindarte un mejor servicio.",
              "¡Gracias!", DialogType.Info);
        }

        print("RATING: $rating");*/
      });
    }
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(""),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.facebookMessenger),
              onPressed: () {
                Navigator.pushNamed(context, "chat/${data.order.orderNumber}");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.mapMarkerAlt),
              onPressed: () {
                Navigator.pushNamed(context, "tracking/${data.order.orderNumber}");
              },
            ),
          ],
          bottom: TabBar(
            indicatorPadding: EdgeInsets.all(16),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: _theme.palette.secondary,
            labelColor: Colors.white,
            indicator: BubbleTabIndicator(
              indicatorHeight: screenHeight(context) * 0.04,
              indicatorColor: _theme.palette.secondary.withOpacity(0.5),
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            tabs: [
              Tab(text: "DETALLE"),
              Tab(text: "HISTORIAL"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrdersList(data.order),
            Records(data.order.id),
          ],
        ),
      ),
    );
  }
}
