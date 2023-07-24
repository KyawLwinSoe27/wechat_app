import 'dart:io';

import 'package:we_chat_app/data/vos/group_vo.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';

abstract class MessageModel {
  Future<void> sendMessage(MessageVO message,String receiverId, File? chosenImage);
  Stream<List<MessageVO>> getMessage(String friendId);
  Future<void> sendGroupMessage(MessageVO message, String groupId);
  Stream<List<MessageVO>> getGroupMessage(String groupId);
  Future<List<String>> getChatMessageUser();
}