import 'package:flutter/cupertino.dart';
import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/data/model/message_model.dart';
import 'package:we_chat_app/data/model/message_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class ChatBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;

  List<String> userIdList = [];
  List<UserVO> userList = [];

  final MessageModel _messageModel = MessageModelImpl();
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();
  ChatBloc() {
    getChattingList();
  }

  void getChattingList() async{
    await _messageModel.getChatMessageUser().then((value) {
      userIdList = value;
      notifySafety();
    });
    for (var element in userIdList) {
      _authenticationModel.getCurrentUserInfoById(element).listen((event) {
        userList.add(event);
        notifySafety();
      });
    }
    print(userList.length);
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