import 'package:flutter/material.dart';
import '../resources/colors.dart';
class InputTextField extends StatelessWidget {
  final String labelName;
  final Function(String) onChanged;
  final TextEditingController textEditingController;
  const InputTextField({
    super.key,
    required this.labelName,
    required this.onChanged,
    required this.textEditingController,
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
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      controller: textEditingController,
      onChanged: (val) => onChanged(val),
    );
  }
}
