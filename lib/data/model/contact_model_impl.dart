import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat_app/data/model/contact_model.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

import '../../network/wechat_chats_data_agent.dart';
import '../../network/wechat_chats_data_agent_impl.dart';
import '../vos/group_vo.dart';

class ContactModelImpl extends ContactModel {
  static final ContactModelImpl _singleton = ContactModelImpl._internal();

  factory ContactModelImpl() {
    return _singleton;
  }

  ContactModelImpl._internal();

  final WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();
  final WeChatChatsDataAgent weChatChatsDataAgent = WeChatChatsDataAgentImpl();



  @override
  Future<void> addNewContact(String userId) async{
    UserVO user = await mDataAgent.getCurrentUserInfoById(userId).first;
    return mDataAgent.addNewFriend(user);
  }

  @override
  Stream<List<UserVO>> getFriendsList() {
    return mDataAgent.getFriendList();
  }

  @override
  Future<void> createGroup(String groupName, File? groupPicture, List<String> members) async{
    UserVO user = await mDataAgent.getCurrentUserInfo().first;
    List<String> memberList = members;
    memberList.add(user.id!);
    int id = DateTime.now().millisecondsSinceEpoch;
    if(groupPicture != null) {
      return weChatChatsDataAgent.uploadGroupProfilePictureToFirebase(groupPicture, id.toString()).then((downloadUrl) {
        GroupVO group = GroupVO(id: id.toString(), name: groupName, profilePicture: downloadUrl, members: memberList, messages: null );
        return weChatChatsDataAgent.createGroup(group);
      });
    } else {
      // Return a resolved Future with null as there's nothing more to do.
      return Future.value(null);
    }
  }

  @override
  Stream<List<GroupVO>> getGroupList() {
    return weChatChatsDataAgent.getGroupList();
  }

}