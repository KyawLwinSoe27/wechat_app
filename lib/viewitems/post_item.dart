import 'package:flutter/material.dart';
import 'package:we_chat_app/data/vos/moments_vo.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class PostItem extends StatelessWidget {
  final MomentsVO? moment;
  final Function() onTap;
  const PostItem({super.key, required this.moment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: MARGIN_LEVEL_1_MIDDLE, vertical: MARGIN_LEVEL_1_MIDDLE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePicture(profilePicture: moment?.postOwnerPhoto),
              const SizedBox(
                width: MARGIN_LEVEL_1_MIDDLE,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      moment?.postOwnerName ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: PRIMARY_COLOR),
                    ),
                    const SizedBox(
                      height: MARGIN_LEVEL_1_5,
                    ),
                    const Text(
                      "15 min ago",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: GREY_COLOR),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.more_horiz,
                size: MARGIN_LEVEL_2_MIDDLE,
              )
            ],
          ),
          const SizedBox(
            height: MARGIN_LEVEL_1_MIDDLE,
          ),
          Text(moment?.postContent ?? ""),
          const SizedBox(
            height: MARGIN_LEVEL_1_MIDDLE,
          ),
          moment?.media == null && moment?.media == [] ? Container() : Column(children: List.generate(moment!.media!.length, (index) => Image.network(moment!.media![index]),),),
          const SizedBox(
            height: MARGIN_LEVEL_1_MIDDLE,
          ),
          Row(
            children: [
              FavouriteButtonAndCount(likeList: moment?.likeCount, onTap: () => onTap(), isLike : moment?.isLike),
              const Spacer(),
              const CommentButtonAndCount(),
              const SizedBox(
                width: MARGIN_LEVEL_1_MIDDLE,
              ),
              const Icon(
                Icons.bookmark,
                color: FAVOURITE_COLOR,
              )
            ],
          ),
          const SizedBox(
            height: MARGIN_LEVEL_1_MIDDLE,
          ),
          const Divider(
            color: GREY_COLOR,
            height: 2,
          )
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
        Icon(
          Icons.comment,
          size: 20,
          color: PRIMARY_COLOR,
        ),
        SizedBox(
          width: MARGIN_LEVEL_1_5,
        ),
        Text(
          "2",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: PRIMARY_COLOR),
        ),
      ],
    );
  }
}

class FavouriteButtonAndCount extends StatelessWidget {
  final List<String>? likeList;
  final Function() onTap;
  final bool? isLike;
  const FavouriteButtonAndCount({super.key, this.likeList, required this.onTap, required this.isLike});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Icon(
            isLike != null && isLike == true ? Icons.favorite : Icons.favorite_outline,
            color: isLike != null && isLike == true ? Colors.red : PRIMARY_COLOR,
            size: 20,
          ),
        ),
        const SizedBox(
          width: MARGIN_LEVEL_1_5,
        ),
        Text(
          likeList?.length.toString() ?? "0",
          style: const TextStyle(
              color: PRIMARY_COLOR, fontWeight: FontWeight.w500, fontSize: 14),
        )
      ],
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final String? profilePicture;
  const ProfilePicture({super.key, this.profilePicture});

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
