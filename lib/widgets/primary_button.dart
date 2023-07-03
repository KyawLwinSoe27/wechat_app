import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonName;
  final Color borderColor;
  final Color buttonColor;
  final Color textColor;
  const PrimaryButton({
    super.key, required this.buttonName, required this.borderColor, required this.buttonColor, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
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
