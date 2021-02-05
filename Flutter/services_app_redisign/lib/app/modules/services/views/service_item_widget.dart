import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/app/modules/services/views/price_widget.dart';
import 'package:services/app/styles/palette.dart';

class ServiceItemWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onAdd;

  ServiceItemWidget({@required this.onPressed, @required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Palette.primary.withOpacity(0.05),
            offset: Offset(0, 15),
          ),
        ],
      ),
      width: Get.width,
      height: 150,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          splashColor: Palette.primary.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Service Title",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                            style: TextStyle(
                              fontSize: 12,
                              color: Palette.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset("assets/icons/settings.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceWidget(125.789),
                    OutlineButton(
                      borderSide: BorderSide(color: Palette.success),
                      onPressed: onAdd,
                      textColor: Palette.success,
                      highlightedBorderColor: Palette.successDark,
                      splashColor: Palette.success.withOpacity(0.05),
                      child: Text("Add to cart"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
