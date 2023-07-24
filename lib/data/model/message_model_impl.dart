import 'dart:io';

import 'package:we_chat_app/data/model/message_model.dart';
import 'package:we_chat_app/data/vos/group_vo.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/network/wechat_chats_data_agent.dart';
import 'package:we_chat_app/network/wechat_chats_data_agent_impl.dart';

class MessageModelImpl extends MessageModel {
  static final MessageModelImpl _singleton = MessageModelImpl._internal();

  factory MessageModelImpl() {
    return _singleton;
  }

  MessageModelImpl._internal();

  final WeChatChatsDataAgent weChatChatsDataAgent = WeChatChatsDataAgentImpl();

  @override
  Future<void> sendMessage(
      MessageVO message, String receiverId, File? chosenImage) async {
    if (chosenImage != null) {
      String imageUrl = await weChatChatsDataAgent.uploadImageToFirebase(
          chosenImage, message.senderId ?? "", receiverId);
      MessageVO messageWithPhotos = MessageVO(
          id: message.id,
          file: imageUrl,
          message: message.message,
          senderName: message.senderName,
          senderProfilePicture: message.senderProfilePicture,
          timestamp: message.timestamp,
          senderId: message.senderId);
      return weChatChatsDataAgent.sendMessage(messageWithPhotos, receiverId);
    } else {
      return weChatChatsDataAgent.sendMessage(message, receiverId);
    }
  }

  @override
  Stream<List<MessageVO>> getMessage(String friendId) {
    return weChatChatsDataAgent.getMessage(friendId);
  }

  @override
  Future<void> sendGroupMessage(MessageVO message, String groupId) {
    return weChatChatsDataAgent.sendGroupMessage(message, groupId);
  }

  @override
  Stream<List<MessageVO>> getGroupMessage(String groupId) {
    return weChatChatsDataAgent.getGroupMessage(groupId);
  }

  @override
  Future<List<String>> getChatMessageUser() {
    return weChatChatsDataAgent.getChatMessageUser();
  }
}
