import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat_app/data/model/contact_model.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

class ContactModelImpl extends ContactModel {
  static final ContactModelImpl _singleton = ContactModelImpl._internal();

  factory ContactModelImpl() {
    return _singleton;
  }

  ContactModelImpl._internal();

  final WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();


  @override
  Future<void> addNewContact(String userId) async{
    UserVO user = await mDataAgent.getCurrentUserInfoById(userId).first;
    return mDataAgent.addNewFriend(user);
  }

  @override
  Stream<List<UserVO>> getFriendsList() {
    return mDataAgent.getFriendList();
  }

}