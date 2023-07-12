
import 'dart:io';

import 'package:we_chat_app/data/vos/moments_vo.dart';

abstract class MomentModel {
  Stream<List<MomentsVO>> getAllMoments();
  Future<void> addNewMoment(String description, String postOwnerId, String postOwnerName, String postOwnerPhoto, List<File>? medias);
  Future<bool> onTapFavouriteButton(String postId);
}