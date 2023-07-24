import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_app/data/vos/get_otp_vo.dart';
import 'package:we_chat_app/data/vos/moments_vo.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

/// OTP
const otpPasswordCollection = "otp_password";
const otpPasswordDocument = "otp_password";

/// USER AUTH
const userCollection = "users";
const friendSubCollection = "friends";

/// MOMENTS
const momentCollection = "moments";
const commentSubCollection = "comments";

/// STORAGE -> USER PHOTO
const userStorageFolder = "user_photos";

/// STORAGE -> MOMENTS PHOTOS
const momentsStorageFolder = "moments_photos";

class CloudFireStoreDataAgentImpl extends WeChatDataAgent {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;


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
    String? token = await firebaseMessaging.getToken();
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    String userId = firebaseAuth.currentUser!.uid;
    return fireStore.collection(userCollection).doc(userId).update({"device_token" : token});
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

  @override
  Future<String> uploadProfilePictureToFirebase(File imageFile) {
    return firebaseStorage
        .ref(userStorageFolder)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(imageFile)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Future<String> uploadMultipleMomentPicture(File media, String postId) {
    return firebaseStorage
        .ref()
        .child(
            "$momentsStorageFolder/$postId/${DateTime.now().millisecondsSinceEpoch}")
        .putFile(media)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Future<void> addNewFriend(UserVO user) async {
    UserVO currentUser = await getCurrentUserInfo().first;
    await fireStore
        .collection(userCollection)
        .doc(firebaseAuth.currentUser?.uid.toString())
        .collection(friendSubCollection)
        .doc(user.id.toString())
        .set(user.toJson());
    await fireStore
        .collection(userCollection)
        .doc(user.id.toString())
        .collection(friendSubCollection)
        .doc(firebaseAuth.currentUser?.uid.toString())
        .set(currentUser.toJson());
  }

  @override
  Stream<List<UserVO>> getFriendList() {
    return fireStore
        .collection(userCollection)
        .doc(firebaseAuth.currentUser?.uid.toString())
        .collection(friendSubCollection)
        .snapshots()
        .map(
          (querySnapShot) => querySnapShot.docs
              .map<UserVO>(
                (documnet) => UserVO.fromJson(
                  documnet.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Future<bool> onTapFavouriteButton(String postId) async {
    DocumentSnapshot documentSnapshot =
        await fireStore.collection(momentCollection).doc(postId).get();
    Map<String, dynamic>? data =
        documentSnapshot.data() as Map<String, dynamic>?;
    if (data != null && data["like_count"] is List<dynamic>) {
      List<dynamic> userList = data['like_count'];
      if (userList.contains(firebaseAuth.currentUser!.uid)) {
        userList.remove(firebaseAuth.currentUser!.uid);
        await FirebaseFirestore.instance
            .collection(momentCollection)
            .doc(postId)
            .update({'like_count': userList});
        await FirebaseFirestore.instance
            .collection(momentCollection)
            .doc(postId)
            .update({'is_like': false});
        print('User removed from the list');
        return false;
      } else {
        userList.add(firebaseAuth.currentUser!.uid);
        await fireStore.collection(momentCollection).doc(postId).update({
          'like_count': userList,
        });
        await FirebaseFirestore.instance
            .collection(momentCollection)
            .doc(postId)
            .update({'is_like': true});
        print('User added to the list');
        return true;
      }
    } else {
      print('Field or document does not exist');
      return false;
    }
  }

  @override
  Future updateUserInfo(UserVO userVO) {
    return fireStore
        .collection(userCollection)
        .doc(userVO.id)
        .set(userVO.toJson());
  }
}
