import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class SubTitleText extends StatelessWidget {
  final String subTitleText;
  const SubTitleText({
    super.key,
    required this.subTitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:const EdgeInsets.only(left: MARGIN_LEVEL_2_25), child: Text(subTitleText,style:const TextStyle(fontWeight: FontWeight.w400,fontSize: 16.0,color: PRIMARY_COLOR_7),));
  }
}