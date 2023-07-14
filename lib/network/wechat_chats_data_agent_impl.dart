import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/wechat_chats_data_agent.dart';

/// MESSAGE MAIN NODE
const messageDatabase = "contactsAndMessaging";

class WeChatChatsDataAgentImpl extends WeChatChatsDataAgent {

  static final WeChatChatsDataAgentImpl _singleton =
  WeChatChatsDataAgentImpl._internal();

  factory WeChatChatsDataAgentImpl() {
    return _singleton;
  }
  WeChatChatsDataAgentImpl._internal();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  /// REALTIME DATABASE
  var databaseRef = FirebaseDatabase.instance.ref();

  @override
  Future<void> sendMessage(MessageVO message, String receiverId) async {
    await databaseRef
        .child(messageDatabase)
        .child(message.senderId ?? "")
        .child(receiverId)
        .child(message.id ?? "")
        .set(message.toJson());
    await databaseRef
        .child(messageDatabase)
        .child(receiverId)
        .child(message.senderId ?? "")
        .child(message.id ?? "")
        .set(message.toJson());
    print("Message Added Successful");
  }

  @override
  Stream<List<MessageVO>> getMessage(String friendId) {
    return databaseRef.child(messageDatabase).child(firebaseAuth.currentUser?.uid ?? "").child(friendId).onValue.map((event) {
      Map<Object?, Object?> snapshotValue =
      event.snapshot.value as Map<Object?, Object?>;
      Map<String?, dynamic> convertedMap = {};
      snapshotValue.forEach((key, value) {
        convertedMap[key.toString()] = value;
      });
      return (convertedMap.values).map<MessageVO>((e) {
        return MessageVO.fromJson(Map<String,dynamic>.from(e));
      }).toList();
    });
  }

  @override
  Stream<List<String>> getChatMessageUser() {
    Stream databaseStream  = databaseRef.child(messageDatabase).child(firebaseAuth.currentUser?.uid ?? "").onValue;
    return databaseStream.map((event) {
      List<String> documentList = [];

      Map<dynamic, dynamic> values = event.snapshot.value;

      values.forEach((key, value) {
        documentList.add(value.toString());
      });

      return documentList;
    });
  }
}
