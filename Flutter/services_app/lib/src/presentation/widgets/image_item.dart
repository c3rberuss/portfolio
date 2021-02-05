import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:services/src/presentation/widgets/card.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({Key key, this.image, this.removeImage}) : super(key: key);
  final File image;
  final Function removeImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: CustomCard(
        elevation: 4,
        content: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FadeInImage(
                height: 100,
                width: 100,
                placeholder: AssetImage("assets/spinner.gif"),
                image: FileImage(image, scale: 3.0),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.timesCircle,
                    color: Colors.red,
                  ),
                  onPressed: removeImage),
            ),
          ],
        ),
      ),
    );
  }
}
