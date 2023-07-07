
import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/contact_model.dart';
import 'package:we_chat_app/data/model/contact_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class ContactsBloc extends ChangeNotifier {
  final ContactModel _model = ContactModelImpl();

  /// STATES
  List<UserVO> userList = [];
  bool isLoading = false;
  bool isDisposed = false;


  ContactsBloc() {
    _model.getFriendsList().listen((userList) {
      this.userList = userList;
      notifySafety();
    });
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