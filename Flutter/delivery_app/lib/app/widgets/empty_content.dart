import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyContent extends StatelessWidget {
  final _style = TextStyle(fontSize: 18);
  final String textLine1;
  final String textLine2;
  final VoidCallback goTo;
  final String buttonText;

  EmptyContent({
    @required this.textLine1,
    @required this.textLine2,
    this.goTo,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/emoji-sad.svg",
          color: Palette.dark,
        ),
        SizedBox(height: 16),
        Text(textLine1, style: _style),
        Text(
          textLine2,
          style: _style.copyWith(fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 16),
        if (goTo != null && buttonText != null && buttonText.isNotEmpty) ...[
          CustomOutlineButton(
            text: buttonText,
            onPressed: goTo,
            buttonType: CustomButtonType.dark,
          )
        ]
      ],
    );
  }
}
