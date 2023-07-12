import 'dart:io';

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
  Future<void> addNewMoment(String description, String postOwnerId, String postOwnerName, String postOwnerPhoto,List<File>? medias) async{
    var postId = DateTime.now().microsecondsSinceEpoch;
    final List<String> downloadURLs = [];
    if(medias != null) {
      for(final media in medias) {
        final downloadURL = await mDataAgent.uploadMultipleMomentPicture(media, postId.toString());
        if (downloadURL.isNotEmpty) {
          downloadURLs.add(downloadURL);
        }
      }
      return craftNewsFeedVO(postId.toString(), description, postOwnerId, postOwnerName, postOwnerPhoto, downloadURLs).then((newMoment) => mDataAgent.addNewMoment(newMoment));
    }
    return craftNewsFeedVO(postId,description,postOwnerId,postOwnerName, postOwnerPhoto, []).then((newMoment) {
      return mDataAgent.addNewMoment(newMoment);
    });
  }

  Future<MomentsVO> craftNewsFeedVO(var postId, String description, String postOwnerId, String postOwnerName, String postOwnerPhoto, List<String> downloadURLs) {
    var newMoment = MomentsVO(
        id: postId.toString(),
        postOwnerId: postOwnerId,
        postOwnerName : postOwnerName,
        postContent: description,
        likeCount: [],
        media: downloadURLs,
        postOwnerPhoto: postOwnerPhoto,
        postTime: DateTime.now(),);
    return Future.value(newMoment);
  }

  @override
  Future<bool> onTapFavouriteButton(String postId) {
    return mDataAgent.onTapFavouriteButton(postId);
  }
}
