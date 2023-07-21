import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/data/model/message_model.dart';
import 'package:we_chat_app/data/model/message_model_impl.dart';
import 'package:we_chat_app/data/vos/group_vo.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../data/model/contact_model.dart';
import '../data/model/contact_model_impl.dart';
import '../network/notification_send.dart';

class PeerToPeerChatBloc extends ChangeNotifier {
  /// Variable
  bool isLoading = false;
  bool isDisposed = false;

  /// USERVO
  String userName = "";
  String profilePicture = "";
  UserVO? friendUserVO;
  UserVO? currentUserVO;

  /// MESSAGE
  String textMessage = "";

  /// Get Message
  List<MessageVO>? messageList;


  /// GROUP
  GroupVO? groupVO;
  bool? isGroup;

  final AuthenticationModel _model = AuthenticationModelImpl();
  final MessageModel _messageModel = MessageModelImpl();

  final ContactModel contactModel = ContactModelImpl();

  final SendNotification sendNotification = SendNotificationImpl();


  PeerToPeerChatBloc(String? friendId, String type) {
    _model.getCurrentUserInfo().listen((user) {
      currentUserVO = user;
      notifySafety();
    });
    if(type == 'friend') {
      isGroup = false;
      notifySafety();
      _model.getCurrentUserInfoById(friendId ?? "").listen((user) {
        userName = user.name ?? "";
        profilePicture = user.profilePicture ?? "";
        friendUserVO = user;
        notifySafety();
        _messageModel.getMessage(friendId ?? "").listen((messages) {
          messageList = messages;
          notifySafety();
        });
      });
    } else {
      isGroup = true;
      notifySafety();
      contactModel.getGroupById(friendId ?? "").listen((group) {
        userName = group.name ?? "";
        profilePicture = group.profilePicture ?? "";
        groupVO = group;
        notifySafety();
        _messageModel.getGroupMessage(friendId ?? "").listen((messages) {
          messageList = messages;
          notifySafety();
        });
      });
    }
  }

  Future<void> sendMessage() async{
    if(textMessage != "") {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      MessageVO messageVO = MessageVO(
        id: timestamp,
          file: "",
          message: textMessage,
          senderName: currentUserVO?.name,
          senderProfilePicture: currentUserVO?.profilePicture,
          timestamp: timestamp,
          senderId: currentUserVO?.id);
       if(!isGroup!) {
         _messageModel.sendMessage(messageVO, friendUserVO?.id ?? "");
         sendNotification.sendNotification(friendUserVO?.deviceToken ?? "", "WeChat App Receive Message From $userName", textMessage);
       } else {
         _messageModel.sendGroupMessage(messageVO, groupVO?.id ?? "");
       }
    }
  }

  

  void onTextChanged(String text) {
    textMessage = text;
    notifySafety();
  }

  void showLoading() {
    isLoading = true;
    notifySafety();
  }

  void hideLoading() {
    isLoading = false;
    notifySafety();
  }

  void notifySafety() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
