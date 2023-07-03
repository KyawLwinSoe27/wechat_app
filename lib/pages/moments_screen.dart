import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/add_new_moment_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/viewitems/post_item.dart';

class MomentsScreen extends StatelessWidget {
  const MomentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(
                      0.5), // Set the color and opacity of the shadow
                  blurRadius: 5, // Set the blur radius of the shadow
                  offset: const Offset(
                      0, 3), // Set the vertical offset of the shadow
                  blurStyle: BlurStyle.outer),
              const BoxShadow(
                color: Colors
                    .transparent, // Set the color to transparent for the other sides
                blurRadius: 5, // Set the blur radius of the shadow
                offset: Offset(0, 0), // No offset for the other sides
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                MOMENTS_TITLE,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 34,
                    color: PRIMARY_COLOR),
              ),
              const Spacer(),
              InkWell(
                onTap: () => navigateToScreen(context,const AddNewMomentScreen()),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PRIMARY_COLOR),
                  child: const Image(
                    image: AssetImage(MOMENT_ACTION_BUTTON),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              // Build and return the individual item widget
              return const PostItem();
            },
          ),
        )
      ],
    );
  }
}
