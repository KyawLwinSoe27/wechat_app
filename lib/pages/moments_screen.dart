import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/add_new_moment_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/utils/extensions.dart';

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

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: MARGIN_LEVEL_1_MIDDLE,
          vertical: MARGIN_LEVEL_1_MIDDLE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const ProfilePicture(),
              const SizedBox(width: MARGIN_LEVEL_1_MIDDLE,),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Ana De Armas",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: PRIMARY_COLOR),),
                    SizedBox(height: MARGIN_LEVEL_1_5,),
                    Text("15 min ago", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: GREY_COLOR),),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz,size: MARGIN_LEVEL_2_MIDDLE,)
            ],
          ),
          const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
          const Text("Nice !"),
          const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
          Image.network(
              "https://ca-times.brightspotcdn.com/dims4/default/522c102/2147483647/strip/true/crop/4718x3604+0+0/resize/1200x917!/format/webp/quality/80/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2F21%2F3491434e446c83711360a43f6978%2Fla-photos-1staff-471763-en-ana-de-armas-mjc-09.jpg"),
          const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
          Row(
            children: const [
              FavouriteButtonAndCount(),
              Spacer(),
              CommentButtonAndCount(),
              SizedBox(width: MARGIN_LEVEL_1_MIDDLE,),
              Icon(Icons.bookmark,color: FAVOURITE_COLOR,)
            ],
          ),
          const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
          const Divider(color: GREY_COLOR,height: 2,)
        ],
      ),
    );
  }
}

class CommentButtonAndCount extends StatelessWidget {
  const CommentButtonAndCount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.comment,size: 20,color: PRIMARY_COLOR,),
        SizedBox(width: MARGIN_LEVEL_1_5,),
        Text("2",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: PRIMARY_COLOR),),
      ],
    );
  }
}

class FavouriteButtonAndCount extends StatelessWidget {
  const FavouriteButtonAndCount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.favorite_outline,color: PRIMARY_COLOR,size: 20,),
        SizedBox(width: MARGIN_LEVEL_1_5,),
        Text("10",style: TextStyle(color: PRIMARY_COLOR,fontWeight: FontWeight.w500,fontSize: 14),)
      ],
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 40,
      height: 40,
      child: CircleAvatar(
        radius: 20, // Image radius
        backgroundImage: NetworkImage(
          'https://i.redd.it/dry65gj3b8a31.jpg',
        ),
      ),
    );
  }
}
