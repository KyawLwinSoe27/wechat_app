import 'dart:io';

import 'package:we_chat_app/data/vos/get_otp_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class AuthenticationModel {
  Future<GetOTPVO> getOTP();
  Future<void> registerNewUser(String email,
      String userName,
      String password,
      String phoneNumber,
      int gender,
      DateTime chooseDOB,
      File? userProfilePicture,);
  Future<void> login(String email, String password);
  bool autoLogin();
  Future<void> logOut();
  Stream<UserVO> getCurrentUserInfo();
  Stream<UserVO> getCurrentUserInfoById(String id);
  Future<void> updateUserInfo(
      String id,
      String email,
      String userName,
      String password,
      String phoneNumber,
      int gender,
      DateTime chooseDOB,
      File? userProfilePicture,
      String deviceToken,
      );
}