import 'package:we_chat_app/data/model/message_model.dart';
import 'package:we_chat_app/data/vos/group_vo.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/network/wechat_chats_data_agent.dart';
import 'package:we_chat_app/network/wechat_chats_data_agent_impl.dart';

class MessageModelImpl extends MessageModel {
  static final MessageModelImpl _singleton =
  MessageModelImpl._internal();

  factory MessageModelImpl() {
    return _singleton;
  }

  MessageModelImpl._internal();

  final WeChatChatsDataAgent weChatChatsDataAgent = WeChatChatsDataAgentImpl();

  @override
  Future<void> sendMessage(MessageVO message, String receiverId) {
    return weChatChatsDataAgent.sendMessage(message, receiverId);
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

}