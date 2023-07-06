import 'dart:io';

import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/moment_model.dart';
import 'package:we_chat_app/data/vos/get_otp_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  static final AuthenticationModelImpl _singleton =
      AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() {
    return _singleton;
  }

  AuthenticationModelImpl._internal();

  final WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  @override
  Future<GetOTPVO> getOTP() {
    return mDataAgent.getOTP();
  }

  Future<void> registerNewUser(
    String email,
    String userName,
    String password,
    String phoneNumber,
    int gender,
    DateTime chooseDOB,
    File? userProfilePicture,
  ) {
    if (userProfilePicture != null) {
      return mDataAgent
          .uploadProfilePictureToFirebase(userProfilePicture)
          .then((downloadUrl) {
        return craftUserVO(email, userName, password, downloadUrl, phoneNumber,
                gender, chooseDOB)
            .then((user) => mDataAgent.registerNewUser(user));
      });
    }
    return craftUserVO(
            email, userName, password, "", phoneNumber, gender, chooseDOB)
        .then((user) => mDataAgent.registerNewUser(user));
  }

  Future<UserVO> craftUserVO(
      String email,
      String userName,
      String password,
      String profilePicture,
      String phoneNumber,
      int gender,
      DateTime chooseDOB) {
    var newUser = UserVO(
        id: "",
        name: userName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        profilePicture: profilePicture,
        dateOfBirth: chooseDOB,
        gender: gender);

    return Future.value(newUser);
  }

  // @override
  // Future<void> registerNewUser(UserVO userVO) {
  //   return craftUserVO(
  //           userVO.email ?? "",
  //           userVO.name ?? "",
  //           userVO.phoneNumber ?? "",
  //           userVO.dateOfBirth ?? DateTime.now(),
  //           userVO.password ?? "",
  //           userVO.gender ?? -1,
  //           "")
  //       .then((user) => mDataAgent.registerNewUser(user));
  // }
  //
  // Future<UserVO> craftUserVO(
  //     String email,
  //     String userName,
  //     String phoneNumber,
  //     DateTime dateOfBirth,
  //     String password,
  //     int gender,
  //     String profilePicture) {
  //   var newUser = UserVO(
  //       id: "",
  //       name: userName,
  //       email: email,
  //       phoneNumber: phoneNumber,
  //       dateOfBirth: dateOfBirth,
  //       password: password,
  //       gender: gender,
  //       profilePicture: profilePicture);
  //
  //   return Future.value(newUser);
  // }

  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  bool autoLogin() {
    return mDataAgent.autoLogin();
  }

  @override
  Stream<UserVO> getCurrentUserInfo() {
    return mDataAgent.getCurrentUserInfo();
  }

  @override
  Stream<UserVO> getCurrentUserInfoById(String id) {
    return mDataAgent.getCurrentUserInfoById(id);
  }
}
