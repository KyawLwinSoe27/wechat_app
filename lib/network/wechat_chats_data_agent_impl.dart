import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_app/data/vos/group_vo.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/wechat_chats_data_agent.dart';

/// MESSAGE MAIN NODE
const messageDatabase = "contactsAndMessaging";
const groupDatabase = "group";

/// STORAGE
const groupPhotos = "group_photos";

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
    return databaseRef
        .child(messageDatabase)
        .child(firebaseAuth.currentUser?.uid ?? "")
        .child(friendId)
        .orderByKey()
        .onValue
        .map((event) {
      Map<Object?, Object?> snapshotValue =
          event.snapshot.value as Map<Object?, Object?>;
      Map<String?, dynamic> convertedMap = {};
      snapshotValue.forEach((key, value) {
        convertedMap[key.toString()] = value;
      });
      return (convertedMap.values).map<MessageVO>((e) {
        return MessageVO.fromJson(Map<String, dynamic>.from(e));
      }).toList();
    });
  }

  @override
  Stream<List<String>> getChatMessageUser() {
    Stream databaseStream = databaseRef
        .child(messageDatabase)
        .child(firebaseAuth.currentUser?.uid ?? "")
        .onValue;
    return databaseStream.map((event) {
      List<String> documentList = [];

      Map<dynamic, dynamic> values = event.snapshot.value;

      values.forEach((key, value) {
        documentList.add(value.toString());
      });

      return documentList;
    });
  }

  @override
  Future<void> createGroup(GroupVO group) async {
    return databaseRef
        .child(groupDatabase)
        .child(group.id ?? "")
        .set(group.toJson());
  }

  @override
  Future<String> uploadGroupProfilePictureToFirebase(
      File imageFile, String groupId) {
    return firebaseStorage
        .ref()
        .child("$groupPhotos/$groupId")
        .putFile(imageFile)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Stream<List<GroupVO>> getGroupList() {
    return databaseRef.child(groupDatabase).onValue.map((event) {
      List<GroupVO> groupsForMember = [];
      String currentUserId = firebaseAuth.currentUser?.uid ?? "";
      Map<dynamic, dynamic>? groupsData =
          event.snapshot.value as Map<dynamic, dynamic>?;
      if (groupsData != null) {
        groupsData.forEach((groupId, groupData) {
          Map<dynamic, dynamic> groupObject =
              groupData as Map<dynamic, dynamic>;
          List<dynamic> memberList = List<dynamic>.from(groupObject['members']);
          if (memberList.contains(currentUserId)) {
            GroupVO group = GroupVO(
              // Assuming your GroupVO class has the necessary properties and constructor.
              // Replace the following lines with the appropriate code based on your class structure.
              id: groupId,
              name: groupObject['name'],
              profilePicture: groupObject['profile_picture'],
              members: List<String>.from(
                  groupObject["members"]?.cast<String>() ?? []),
              messages: groupObject["messages"],
              // Add other properties as needed.
            );
            groupsForMember.add(group);
          }
        });
      }
      return groupsForMember;
    });
  }
}
