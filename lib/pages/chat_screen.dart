import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/chat_bloc.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/pages/peer_to_peer_chat_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/widgets/page_title_text.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ChatBloc(),
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: AppBar(
          backgroundColor: PURE_WHITE_COLOR,
          title: const PageTitleText(text: CHATS),
          actions: [
            InkWell(
              onTap: null,
              child: Container(
                margin: const EdgeInsets.all(MARGIN_LEVEL_1_MIDDLE),
                width: 60,
                height: 32,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(MARGIN_LEVEL_1_5),
                ),
                child: Center(child: Icon(Icons.search)),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: MARGIN_LEVEL_1_MIDDLE,
                vertical: MARGIN_LEVEL_1_MIDDLE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      ACTIVE_NOW,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: GREY_COLOR),
                    ),
                    const SizedBox(
                      height: MARGIN_LEVEL_1_MIDDLE,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) =>
                          const ActiveNowFriendList()),
                    )
                  ],
                ),
                Consumer<ChatBloc>(
                  builder: (context, bloc, child) => bloc.userList.isNotEmpty ? Container(
                    padding: EdgeInsets.only(bottom: 50),
                    height: 700,
                    child: ListView.builder(
                        itemCount: bloc.userList.length,
                        itemBuilder: (BuildContext context,
                            int index) => ChatListObjectWidet(user: bloc.userList[index],)),
                  ) : const Center(child: Text("Start Chatting with your friend"),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatListObjectWidet extends StatelessWidget {
  final UserVO? user;
  const ChatListObjectWidet({
    super.key,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToScreen(context, PeerToPeerChatScreen(friendId: user?.id ?? "", type: 'friend',)),
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: MARGIN_LEVEL_1_5),
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: PURE_WHITE_COLOR,
        ),
        height: 70,
        child: Row(
          children: [
            Stack(
              children: [
                 SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        user?.profilePicture ?? "https://ca-times.brightspotcdn.com/dims4/default/522c102/2147483647/strip/true/crop/4718x3604+0+0/resize/1200x917!/format/webp/quality/80/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2F21%2F3491434e446c83711360a43f6978%2Fla-photos-1staff-471763-en-ana-de-armas-mjc-09.jpg"),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: ACTIVE_NOW_COLOR,
                      border: Border.all(
                          color: PURE_WHITE_COLOR,
                          width: 4.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: MARGIN_LEVEL_1_MIDDLE,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? "",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: PRIMARY_COLOR),
                ),
                Spacer(),
                Text(
                  "You sent a video",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: GREY_COLOR),
                ),
                SizedBox(
                  height: MARGIN_LEVEL_1_5,
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  "5min",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: PRIMARY_COLOR),
                ),
                Spacer(),
                Icon(Icons.notifications_off_outlined)
              ],
            ),
            const SizedBox(
              width: MARGIN_LEVEL_1_MIDDLE,
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveNowFriendList extends StatelessWidget {
  const ActiveNowFriendList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => navigateToScreen(context, PeerToPeerChatScreen()),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: MARGIN_LEVEL_1_5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://ca-times.brightspotcdn.com/dims4/default/522c102/2147483647/strip/true/crop/4718x3604+0+0/resize/1200x917!/format/webp/quality/80/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2F21%2F3491434e446c83711360a43f6978%2Fla-photos-1staff-471763-en-ana-de-armas-mjc-09.jpg"),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: ACTIVE_NOW_COLOR,
                      border: Border.all(color: PURE_WHITE_COLOR, width: 4.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const Center(
              child: SizedBox(
                width: 80,
                child: Text("Kyaw Lwin Soe"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
