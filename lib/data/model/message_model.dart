import 'package:we_chat_app/data/vos/message_vo.dart';

abstract class MessageModel {
  Future<void> sendMessage(MessageVO message,String receiverId);
  Stream<List<MessageVO>> getMessage(String friendId);
}