import 'dart:io';

import 'package:we_chat_app/data/vos/get_otp_vo.dart';
import 'package:we_chat_app/data/vos/moments_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class WeChatDataAgent {
  Future<GetOTPVO> getOTP();
  Future registerNewUser(UserVO userVO);
  Future login(String email, String password);
  bool autoLogin();
  Future<void> logout();
  Stream<UserVO> getCurrentUserInfo();
  Stream<UserVO> getCurrentUserInfoById(String id);
  Stream<List<MomentsVO>> getAllMoments();
  Future<void> addNewMoment(MomentsVO momentsVO);
  Future<String> uploadProfilePictureToFirebase(File imageFile);
}