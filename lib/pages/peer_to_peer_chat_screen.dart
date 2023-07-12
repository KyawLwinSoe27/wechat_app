import 'package:flutter/material.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';

class PeerToPeerChatScreen extends StatelessWidget {
  const PeerToPeerChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BACKGROUND_COLOR,
          leading: GestureDetector(
            onTap: null,
            child: const BackButton(color: PRIMARY_COLOR,),
          ),
          title: Row(
            children: <Widget>[
              const CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://i.redd.it/dry65gj3b8a31.jpg'),
                  radius: 16),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Kyaw Lwin Soe",
                    style: TextStyle(color: PRIMARY_COLOR),
                  ),
                  Text("online",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: GREY_COLOR),)
                ],
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.more_vert, size: 20,color: PRIMARY_COLOR),
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
              reverse: true,
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) => const ChatMessageWidget(),

            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: PURE_WHITE_COLOR
                ),
                padding: EdgeInsets.symmetric(horizontal: MARGIN_LEVEL_1_MIDDLE),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Type a message",
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: PRIMARY_COLOR),
                          child: Icon(
                            Icons.send,
                            color: PURE_WHITE_COLOR,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: PURE_WHITE_COLOR),
                          child: Icon(
                            Icons.image_outlined,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: PURE_WHITE_COLOR),
                          child: Icon(
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
                          child: Icon(
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
                          child: Icon(
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
                          child: Icon(
                            Icons.keyboard_voice,
                            color: PRIMARY_COLOR,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    super.key,
  });

  final isMe = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MARGIN_LEVEL_1_MIDDLE),
      padding: EdgeInsets.symmetric(vertical: MARGIN_LEVEL_1_MIDDLE),
      height: 75,
      decoration: BoxDecoration(
        color:isMe ? PRIMARY_COLOR : OTHER_SENT_BG_COLOR,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              isMe ? Container() : const CircleAvatar(
                  backgroundImage:
                  NetworkImage('https://i.redd.it/dry65gj3b8a31.jpg'),
                  radius: 16),
              isMe ? Container() : const SizedBox(width: MARGIN_LEVEL_1_MIDDLE,),
              Text("I'm Chatting a robot",style: TextStyle(color:isMe ? PURE_WHITE_COLOR : PRIMARY_COLOR),),
            ],
          ),
          const SizedBox(height: MARGIN_LEVEL_1_5,),
          Row(
            mainAxisAlignment:isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text("12:30"),
              isMe ? Icon(Icons.add) : Container()
            ],
          )
        ],
      ),
    );
  }
}