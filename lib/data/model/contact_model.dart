import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class ContactModel {
  Future<void> addNewContact(String userId);
  Stream<List<UserVO>> getFriendsList();
}