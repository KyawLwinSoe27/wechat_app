import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonName;
  final Color borderColor;
  final Color buttonColor;
  final Color textColor;
  final double width;
  final double height;
  const PrimaryButton({
    super.key, required this.buttonName, required this.borderColor, required this.buttonColor, required this.textColor, this.width = 150.0, this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5.0),
          color: buttonColor),
      child: Center(
          child: Text(
            buttonName,
        style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: FONT_SIZE_MEDIUM_6,color: textColor),
      )),
    );
  }
}
