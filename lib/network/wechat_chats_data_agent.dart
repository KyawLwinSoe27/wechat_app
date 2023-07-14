import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class WeChatChatsDataAgent {
  Future<void> sendMessage(MessageVO message,String receiverId);
  Stream<List<MessageVO>> getMessage(String friendId);
  Stream<List<String>> getChatMessageUser();
}