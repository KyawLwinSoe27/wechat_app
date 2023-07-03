import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: SizedBox(
          width: MARGIN_LEVEL_3_MIDDLE,
          height: MARGIN_LEVEL_3_MIDDLE,
          child: LoadingIndicator(
            indicatorType: Indicator.audioEqualizer,
            colors: [PRIMARY_COLOR],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}