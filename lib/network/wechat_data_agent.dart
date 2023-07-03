import 'package:we_chat_app/data/vos/get_otp_vo.dart';

abstract class WeChatDataAgent {
  Future<GetOTPVO> getOTP();
}