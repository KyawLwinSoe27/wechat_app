import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class TitleText extends StatelessWidget {
  final String titleText;
  const TitleText({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(left: MARGIN_LEVEL_2_25),
      child: Text(titleText,style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 30.0,color: PRIMARY_COLOR),),
    );
  }
}