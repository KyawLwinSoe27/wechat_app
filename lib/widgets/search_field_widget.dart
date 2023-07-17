import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: MARGIN_LEVEL_1_MIDDLE, vertical: MARGIN_LEVEL_1_MIDDLE),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: SEARCH_FIELD_BG_COLOR,
      ),
      child: Row(
        children: const [
          SizedBox(
            width: MARGIN_LEVEL_1_MIDDLE,
          ),
          Icon(Icons.search),
          SizedBox(
            width: MARGIN_LEVEL_1_LAST,
          ),
          SizedBox(
            width: 280,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Username',
              ),
            ),
          ),
          Icon(Icons.close)
        ],
      ),
    );
  }
}
