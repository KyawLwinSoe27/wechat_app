import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/contact_model.dart';
import 'package:we_chat_app/data/model/contact_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class CreateNewGroupBloc extends ChangeNotifier {
  /// STATES
  File? chooseProfilePicture;
  List<UserVO> userList = [];
  bool isLoading = false;
  bool isDisposed = false;
  Map<String, List<UserVO>>? groupedUsers;
  List<String> indexList = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  List<UserVO>  selectedUserList = [];
  List<String> selectedUserId = [];
  String groupName = "";

  final ContactModel _model = ContactModelImpl();

  CreateNewGroupBloc() {
    _model.getFriendsList().listen((userList) {
      this.userList = userList;
      notifySafety();
      groupUsersByName(userList);
    });
  }

  void groupUsersByName(List<UserVO> userList) {
    Map<String, List<UserVO>> groupedUsers = {};

    for (UserVO user in userList) {
      String firstCharacter = user.name![0].toUpperCase();

      if (groupedUsers.containsKey(firstCharacter)) {
        groupedUsers[firstCharacter]!.add(user);
      } else {
        groupedUsers[firstCharacter] = [user];
      }
    }
    this.groupedUsers = groupedUsers;
    notifySafety();
  }

  onSelectUser(UserVO user) {
    if(selectedUserList.contains(user)){
      selectedUserList.remove(user);
      notifySafety();
    } else {
      selectedUserList.add(user);
      notifySafety();
    }
  }

  onUnselectUser(UserVO user) {
    if(selectedUserList.contains(user)){
      selectedUserList.remove(user);
      notifySafety();
    }
  }

  onImageChoose(File image) {
    chooseProfilePicture = image;
    notifySafety();
  }

  onGroupNameChange(String groupName) {
    this.groupName = groupName;
    notifySafety();
  }

  Future<void> onTapGroupCreate() async{
    showLoading();
    if(selectedUserList.isNotEmpty) {
      for (var element in selectedUserList) {
        selectedUserId.add(element.id!);
      }
      _model.createGroup(groupName, chooseProfilePicture, selectedUserId).whenComplete(() => hideLoading());
    }
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