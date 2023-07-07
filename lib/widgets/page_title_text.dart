import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';

class PageTitleText extends StatelessWidget {
  final String text;
  const PageTitleText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:const TextStyle(color: PRIMARY_COLOR,fontSize: 30,fontWeight: FontWeight.w600),
    );
  }
}