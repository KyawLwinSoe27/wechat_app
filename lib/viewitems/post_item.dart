import 'package:flutter/material.dart';
import 'package:we_chat_app/data/vos/moments_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class PostItem extends StatelessWidget {
  final MomentsVO? moment;
  const PostItem({
    super.key,
    required this.moment
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
              ProfilePicture(profilePicture : moment?.postOwnerPhoto),
              const SizedBox(width: MARGIN_LEVEL_1_MIDDLE,),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(moment?.postOwnerName ?? "",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: PRIMARY_COLOR),),
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
          Text(moment?.postContent ?? ""),
          const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
          Image.network(
              "https://ca-times.brightspotcdn.com/dims4/default/522c102/2147483647/strip/true/crop/4718x3604+0+0/resize/1200x917!/format/webp/quality/80/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2F21%2F3491434e446c83711360a43f6978%2Fla-photos-1staff-471763-en-ana-de-armas-mjc-09.jpg"),
          const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
          Row(
            children: [
              FavouriteButtonAndCount(likeList : moment?.likeCount),
              const Spacer(),
              const CommentButtonAndCount(),
              const SizedBox(width: MARGIN_LEVEL_1_MIDDLE,),
              const Icon(Icons.bookmark,color: FAVOURITE_COLOR,)
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
  List<String>? likeList;
   FavouriteButtonAndCount({
    super.key,
    this.likeList
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.favorite_outline,color: PRIMARY_COLOR,size: 20,),
        const SizedBox(width: MARGIN_LEVEL_1_5,),
        Text(likeList?.length.toString() ?? "0",style: TextStyle(color: PRIMARY_COLOR,fontWeight: FontWeight.w500,fontSize: 14),)
      ],
    );
  }
}

class ProfilePicture extends StatelessWidget {
  String? profilePicture;
   ProfilePicture({
    super.key,
    this.profilePicture
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CircleAvatar(
        radius: 20, // Image radius
        backgroundImage: NetworkImage(
          profilePicture ?? 'https://i.redd.it/dry65gj3b8a31.jpg',
        ),
      ),
    );
  }
}