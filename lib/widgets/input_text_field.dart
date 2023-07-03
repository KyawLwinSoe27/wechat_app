import 'package:flutter/material.dart';
import '../resources/colors.dart';
class InputTextField extends StatelessWidget {
  final String labelName;
  const InputTextField({
    super.key,
    required this.labelName,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: PRIMARY_COLOR),
        ),
        enabledBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: PRIMARY_COLOR),
        ),
        labelText: labelName,
        labelStyle:const TextStyle(color: Colors.grey),
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
    );
  }
}
