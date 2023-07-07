import 'package:json_annotation/json_annotation.dart';
import 'comment_vo.dart';
part 'moments_vo.g.dart';

@JsonSerializable()
class MomentsVO {
  @JsonKey(name: "post_id")
  String? id;

  @JsonKey(name: "post_owner_id")
  String? postOwnerId;

  @JsonKey(name: "content")
  String? postContent;

  @JsonKey(name: "like_count")
  List<String>? likeCount;

  @JsonKey(name: "media")
  List<String>? media;

  @JsonKey(name: "post_time")
  DateTime? postTime;

  @JsonKey(name: "post_owner_name")
  String? postOwnerName;

  @JsonKey(name: "post_owner_photo")
  String? postOwnerPhoto;

  MomentsVO(
      {this.id,
      this.postOwnerId,
      this.postContent,
      this.likeCount,
      this.media,
      this.postTime,
      this.postOwnerName,
        this.postOwnerPhoto
      });

  factory MomentsVO.fromJson(Map<String,dynamic> json) => _$MomentsVOFromJson(json);
  Map<String,dynamic> toJson() => _$MomentsVOToJson(this);
}