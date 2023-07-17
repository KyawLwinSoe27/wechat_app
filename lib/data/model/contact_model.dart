import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../vos/group_vo.dart';

abstract class ContactModel {
  Future<void> addNewContact(String userId);
  Stream<List<UserVO>> getFriendsList();
  Future<void> createGroup(String groupName, File? groupPicture,List<String> members);
  Stream<List<GroupVO>> getGroupList();
}