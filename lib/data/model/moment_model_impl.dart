import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/data/model/moment_model.dart';
import 'package:we_chat_app/data/vos/moments_vo.dart';
import 'package:we_chat_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:we_chat_app/network/wechat_data_agent.dart';

class MomentModelImpl extends MomentModel {
  static final MomentModelImpl _singleton = MomentModelImpl._internal();

  factory MomentModelImpl() {
    return _singleton;
  }

  MomentModelImpl._internal();

  final WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();
  final AuthenticationModel authenticationModel = AuthenticationModelImpl();

  @override
  Stream<List<MomentsVO>> getAllMoments() {
    return mDataAgent.getAllMoments();
  }

  @override
  Future<void> addNewMoment(String description, String postOwnerId, String postOwnerName) {
    return craftNewsFeedVO(description,postOwnerId,postOwnerName).then((newMoment) {
      return mDataAgent.addNewMoment(newMoment);
    });
  }

  Future<MomentsVO> craftNewsFeedVO(String description, String postOwnerId, String postOwnerName) {
    var milliseconds = DateTime.now().microsecondsSinceEpoch;
    var newMoment = MomentsVO(
        id: milliseconds.toString(),
        postOwnerId: postOwnerId,
        postOwnerName : postOwnerName,
        postContent: description,
        likeCount: 0,
        media: "",
        postTime: DateTime.now());
    return Future.value(newMoment);
  }
}
