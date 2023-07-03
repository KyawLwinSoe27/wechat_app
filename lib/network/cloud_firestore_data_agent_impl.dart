import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_chat_app/data/vos/get_otp_vo.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

const otpPasswordCollection = "otp_password";
const otpPasswordDocument = "otp_password";

class CloudFireStoreDataAgentImpl extends WeChatDataAgent {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Future<GetOTPVO> getOTP() {
    return fireStore
        .collection(otpPasswordCollection)
        .doc(otpPasswordDocument)
        .get()
        .then((documentSnapShot) {
      return GetOTPVO.fromJson(documentSnapShot.data()!);
    });
  }
}
