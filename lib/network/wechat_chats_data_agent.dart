import 'dart:io';

import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../data/vos/group_vo.dart';

abstract class WeChatChatsDataAgent {
  Future<String> uploadImageToFirebase(File imageFile, String senderId, String receiverId);
  Future<void> sendMessage(MessageVO message,String receiverId);
  Stream<List<MessageVO>> getMessage(String friendId);
  // Stream<List<String>> getChatMessageUser();
  Future<List<String>> getChatMessageUser();
  Future<void> createGroup(GroupVO group);
  Future<String> uploadGroupProfilePictureToFirebase(File imageFile, String groupId);
  Stream<List<GroupVO>> getGroupList();
  Stream<GroupVO> getGroupById(String groupId);
  Future<void> sendGroupMessage(MessageVO message, String groupId);
  Stream<List<MessageVO>> getGroupMessage(String groupId);
}