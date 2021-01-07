import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megalibreria/src/blocs/products/bloc.dart';
import 'package:megalibreria/src/models/args/products_args.dart';
import 'package:megalibreria/src/presentation/widgets/custom_app_bar.dart';
import 'package:megalibreria/src/presentation/widgets/header.dart';
import 'package:megalibreria/src/presentation/widgets/products_grid.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsArgs args = ModalRoute.of(context).settings.arguments;
    BlocProvider.of<ProductsBloc>(context).add(FetchProductsEvent(args.id));

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ProductsBloc>(context).add(ClearProductsStateEvent());
        return true;
      },
      child: Scaffold(
          key: context.repository<GlobalKey<ScaffoldState>>(),
          appBar: CustomAppBar(title: args.name, showSearchButton: true),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: <Widget>[
                  Header(text: "Catálogo de productos"),
                  ProductsGrid(args.id),
                ],
              );
            },
          )),
    );
  }
}
