import 'package:we_chat_app/data/model/wechat_model.dart';
import 'package:we_chat_app/data/vos/get_otp_vo.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

class AuthenticationModelImpl extends WeChatModel {
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

}