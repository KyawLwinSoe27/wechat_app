import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/wechat_model.dart';
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

  @override
  Future<void> registerNewUser(UserVO userVO) {
    return craftUserVO(
            userVO.email ?? "",
            userVO.name ?? "",
            userVO.phoneNumber ?? "",
            userVO.dateOfBirth ?? DateTime.now(),
            userVO.password ?? "",
            userVO.gender ?? -1,
            "")
        .then((user) => mDataAgent.registerNewUser(user));
  }

  Future<UserVO> craftUserVO(
      String email,
      String userName,
      String phoneNumber,
      DateTime dateOfBirth,
      String password,
      int gender,
      String profilePicture) {
    var newUser = UserVO(
        id: "",
        name: userName,
        email: email,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        password: password,
        gender: gender,
        profilePicture: profilePicture);

    return Future.value(newUser);
  }

  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  bool autoLogin() {
    return mDataAgent.autoLogin();
  }
}
