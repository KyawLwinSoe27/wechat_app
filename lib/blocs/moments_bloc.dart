
import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/moment_model.dart';
import 'package:we_chat_app/data/model/moment_model_impl.dart';
import 'package:we_chat_app/data/vos/moments_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';

class MomentsBloc extends ChangeNotifier {
  /// STATES
  bool isDisposed = false;
  List<MomentsVO>? momentList;
  List<UserVO> userList = [];
  bool isLoading = false;

  final MomentModel socialMediaModel = MomentModelImpl();
  final AuthenticationModel authenticationModel = AuthenticationModelImpl();

  MomentsBloc() {
    socialMediaModel.getAllMoments().listen((momentList) {
      this.momentList = momentList;
      notifySafety();
      // momentList.forEach((element) {
      //   authenticationModel.getCurrentUserInfoById(element.postOwnerId!).listen((user) {
      //     userList.add(user);
      //     notifySafety();
      //   });
      // });
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