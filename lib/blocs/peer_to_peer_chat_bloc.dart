import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/data/model/message_model.dart';
import 'package:we_chat_app/data/model/message_model_impl.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

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

  final AuthenticationModel _model = AuthenticationModelImpl();
  final MessageModel _messageModel = MessageModelImpl();

  PeerToPeerChatBloc(String? friendId) {
    _model.getCurrentUserInfo().listen((user) {
      currentUserVO = user;
      notifySafety();
    });
    _model.getCurrentUserInfoById(friendId ?? "").listen((user) {
      userName = user.name ?? "";
      profilePicture = user.profilePicture ?? "";
      friendUserVO = user;
      notifySafety();
    });
    _messageModel.getMessage(friendId ?? "").listen((messages) {
      messageList = messages;
      notifySafety();
    });
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
       _messageModel.sendMessage(messageVO, friendUserVO?.id ?? "");
       textMessage = "";
       notifySafety();
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
