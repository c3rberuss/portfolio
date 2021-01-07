import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megalibreria/src/blocs/order/bloc.dart';

import 'empty.dart';
import 'order_item.dart';

class ListItemsOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return BlocBuilder<OrderBloc, OrderState>(
      builder: (BuildContext context, OrderState state) {

        if (state.detail.isEmpty) {
          return EmptyContent("Aún no ha agregado items a su orden");
        }

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {

            if (index == state.detail.length-1) {
              return OrderItem(marginBottom: 16, product: state.detail[index], index: index,);
            }

            return OrderItem(product: state.detail[index], index: index,);

          },
          itemCount: state.detail.length,
        );
      },
    );
  }
}
