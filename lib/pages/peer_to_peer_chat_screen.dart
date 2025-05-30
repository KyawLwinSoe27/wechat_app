import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/peer_to_peer_chat_bloc.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class PeerToPeerChatScreen extends StatefulWidget {
  final String friendId;
  final String type;
  const PeerToPeerChatScreen(
      {Key? key, required this.friendId, required this.type})
      : super(key: key);

  @override
  State<PeerToPeerChatScreen> createState() => _PeerToPeerChatScreenState();
}

class _PeerToPeerChatScreenState extends State<PeerToPeerChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PeerToPeerChatBloc(widget.friendId, widget.type),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: BACKGROUND_COLOR,
            leading: GestureDetector(
              onTap: null,
              child: const BackButton(
                color: PRIMARY_COLOR,
              ),
            ),
            title: Row(
              children: <Widget>[
                Consumer<PeerToPeerChatBloc>(
                  builder: (context, bloc, child) => CircleAvatar(
                    backgroundImage: NetworkImage(bloc.profilePicture),
                    radius: 16,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Consumer<PeerToPeerChatBloc>(
                  builder: (context, bloc, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bloc.userName,
                        style: const TextStyle(color: PRIMARY_COLOR),
                      ),
                      const Visibility(
                        visible: false,
                        child: Text(
                          "online",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: GREY_COLOR),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.more_vert, size: 20, color: PRIMARY_COLOR),
              ),
            ],
          ),
          body: Stack(
            children: [
              Consumer<PeerToPeerChatBloc>(
                builder: (context, bloc, child) => Container(
                  margin: EdgeInsets.only(
                      bottom: bloc.chooseImage != null
                          ? (MARGIN_LEVEL_5_LAST + MARGIN_LEVEL_5_LAST)
                          : MARGIN_LEVEL_5_LAST),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: bloc.messageList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) =>
                        ChatMessageWidget(
                      message: bloc.messageList?[index],
                      currentUserId: bloc.currentUserVO?.id ?? "",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(color: PURE_WHITE_COLOR),
                  padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_LEVEL_1_MIDDLE),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<PeerToPeerChatBloc>(
                        builder: (context, bloc, child) {
                          return bloc.chooseImage != null
                              ? Stack(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.file(bloc.chooseImage!),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () => bloc.removeImage(),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container();
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Consumer<PeerToPeerChatBloc>(
                              builder: (context, bloc, child) => TextField(
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                  hintText: "Type a message",
                                ),
                                onChanged: (value) => bloc.onTextChanged(value),
                              ),
                            ),
                          ),
                          Consumer<PeerToPeerChatBloc>(
                            builder: (context, bloc, child) => InkWell(
                              onTap: () {
                                 bloc.sendMessage();
                                 setState(() {
                                   textEditingController.text = "";
                                 });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: PRIMARY_COLOR),
                                child: const Icon(
                                  Icons.send,
                                  color: PURE_WHITE_COLOR,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: MARGIN_LEVEL_1_MIDDLE,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer<PeerToPeerChatBloc>(
                            builder: (context, bloc, child) => InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  bloc.onImageChoose(File(image.path));
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: PURE_WHITE_COLOR),
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: PRIMARY_COLOR,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: PURE_WHITE_COLOR),
                            child: const Icon(
                              Icons.camera,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: PURE_WHITE_COLOR),
                            child: const Icon(
                              Icons.gif_outlined,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: PURE_WHITE_COLOR),
                            child: const Icon(
                              Icons.pin_drop,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: PURE_WHITE_COLOR),
                            child: const Icon(
                              Icons.keyboard_voice,
                              color: PRIMARY_COLOR,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: MARGIN_LEVEL_1_MIDDLE,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final MessageVO? message;
  final String currentUserId;

  const ChatMessageWidget(
      {super.key, required this.message, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: MARGIN_LEVEL_1_MIDDLE, horizontal: MARGIN_LEVEL_1_MIDDLE),
      height: message?.file != null && message?.file != "" ? 280 :  80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: message?.senderId == currentUserId
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: message?.senderId == currentUserId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              message?.senderId == currentUserId
                  ? Container()
                  : const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.redd.it/dry65gj3b8a31.jpg'),
                      radius: 16),
              message?.senderId == currentUserId
                  ? Container()
                  : const SizedBox(
                      width: MARGIN_LEVEL_1_MIDDLE,
                    ),
              Column(
                crossAxisAlignment: message?.senderId == currentUserId
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  message?.file != null && message?.file != "" ? Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Image.network(message!.file!),
                  ) : Container(),
                  message?.message != "" ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: MARGIN_LEVEL_1_MIDDLE, horizontal: MARGIN_LEVEL_1_MIDDLE),
                    decoration: BoxDecoration(
                        color: message?.senderId == currentUserId
                            ? PRIMARY_COLOR
                            : OTHER_SENT_BG_COLOR,
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: message?.senderId == currentUserId
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message?.message ?? "",
                          style: TextStyle(
                              color: message?.senderId == currentUserId
                                  ? PURE_WHITE_COLOR
                                  : PRIMARY_COLOR),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: message?.senderId == currentUserId
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            const Text("12:30"),
                            message?.senderId == currentUserId
                                ? const Icon(Icons.add)
                                : Container()
                          ],
                        )
                      ],
                    ),
                  ) : Container(),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: MARGIN_LEVEL_1_5,
          ),
        ],
      ),
    );
  }
}
