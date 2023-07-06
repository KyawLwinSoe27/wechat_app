import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_chat_app/data/vos/get_otp_vo.dart';
import 'package:we_chat_app/data/vos/moments_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

/// OTP
const otpPasswordCollection = "otp_password";
const otpPasswordDocument = "otp_password";

/// USER AUTH
const userCollection = "users";

/// MOMENTS
const momentCollection = "moments";
const commentSubCollection = "comments";

class CloudFireStoreDataAgentImpl extends WeChatDataAgent {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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

  @override
  Future registerNewUser(UserVO userVO) {
    return firebaseAuth
        .createUserWithEmailAndPassword(
            email: userVO.email ?? "", password: userVO.password ?? "")
        .then((UserCredential credential) =>
            credential.user?..updateDisplayName(userVO.name))
        .then((user) {
      userVO.id = (user?.uid ?? "");
      _addNewUser(userVO);
    });
  }

  Future<void> _addNewUser(UserVO userVO) {
    return fireStore
        .collection(userCollection)
        .doc(userVO.id)
        .set(userVO.toJson());
  }

  @override
  Future login(String email, String password) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    return firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  bool autoLogin() {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logout() {
    return firebaseAuth.signOut();
  }

  @override
  Stream<UserVO> getCurrentUserInfo() {
    return fireStore
        .collection(userCollection)
        .doc(firebaseAuth.currentUser?.uid.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => UserVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Stream<List<MomentsVO>> getAllMoments() {
    return fireStore
        .collection(momentCollection)
        .snapshots()
        .map((querySnapShot) => querySnapShot.docs
            .map<MomentsVO>(
              (document) => MomentsVO.fromJson(
                document.data(),
              ),
            )
            .toList());
  }

  @override
  Stream<UserVO> getCurrentUserInfoById(String id) {
    return fireStore
        .collection(userCollection)
        .doc(id.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => UserVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Future<void> addNewMoment(MomentsVO momentsVO) {
    return fireStore
        .collection(momentCollection)
        .doc(momentsVO.id.toString())
        .set(momentsVO.toJson());
  }
}
