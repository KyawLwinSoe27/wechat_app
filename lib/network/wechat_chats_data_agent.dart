import 'dart:io';

import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../data/vos/group_vo.dart';

abstract class WeChatChatsDataAgent {
  Future<void> sendMessage(MessageVO message,String receiverId);
  Stream<List<MessageVO>> getMessage(String friendId);
  Stream<List<String>> getChatMessageUser();
  Future<void> createGroup(GroupVO group);
  Future<String> uploadGroupProfilePictureToFirebase(File imageFile, String groupId);
  Stream<List<GroupVO>> getGroupList();
}