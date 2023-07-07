
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/moment_model.dart';
import 'package:we_chat_app/data/model/moment_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';

class AddNewMomentBloc extends ChangeNotifier {

  /// STATES
  bool isLoading = false;
  bool isDisposed = false;
  UserVO? userVO;
  String content = "";
  String userId = "";
  List<File>? medias;

  /// Model
  final MomentModel _momentModel = MomentModelImpl();
  final AuthenticationModel authenticationModel = AuthenticationModelImpl();

  AddNewMomentBloc() {
    authenticationModel.getCurrentUserInfo().listen((user) {
      userVO = user;
      notifySafety();
    });
  }

  void onChangedContent(String content) {
    this.content = content;
    notifySafety();
  }

  onImageChoose(List<File> images) {
    medias = images;
    notifySafety();
  }

  Future addNewPost() {
    if(content.isNotEmpty) {
      return _momentModel.addNewMoment(content, userVO?.id ?? "", userVO?.name ?? "", userVO?.profilePicture ?? "", medias);
    } else {
      return Future.error("error");
    }
  }

  void _prepopulateDataForAddNewPost() {
    userId = userVO?.id ?? "";
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