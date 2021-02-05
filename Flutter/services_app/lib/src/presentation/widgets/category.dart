import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/services/services_bloc.dart';
import 'package:services/src/blocs/services/services_event.dart';

import 'card.dart';

class Category extends StatelessWidget {
  Category({Key key, this.title, this.imagePath, this.categoryId}) : super();

  final String title;
  final String imagePath;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CustomCard(
        content: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CachedNetworkImage(
                height: 45,
                width: 45,
                imageUrl: imagePath,
                placeholder: (ctx, url) {
                  return CircularProgressIndicator();
                },
                errorWidget: (ctx, url, error) {
                  return Icon(
                    Icons.broken_image,
                    size: 40,
                  );
                },
              ),
              Text(title),
            ],
          ),
        ),
      ),
      onTap: () {
        BlocProvider.of<ServicesBloc>(context).add(FetchServicesEvent(categoryId));
        Navigator.pushNamed(context, "services/$categoryId");
      },
    );
  }
}
