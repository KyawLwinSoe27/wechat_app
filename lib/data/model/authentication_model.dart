import 'package:we_chat_app/data/vos/get_otp_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

abstract class AuthenticationModel {
  Future<GetOTPVO> getOTP();
  Future<void> registerNewUser(UserVO userVO);
  Future<void> login(String email, String password);
  bool autoLogin();
}