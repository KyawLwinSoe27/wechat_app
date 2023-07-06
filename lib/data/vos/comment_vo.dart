import 'package:json_annotation/json_annotation.dart';
part 'comment_vo.g.dart';
@JsonSerializable()
class CommentVO {
  @JsonKey(name: "comment_id")
  String? id;

  @JsonKey(name: "comment_owner_id")
  String? commentOwnerId;

  @JsonKey(name: "post_id")
  String? postId;

  @JsonKey(name: "comment_content")
  String? commentContent;

  @JsonKey(name: "comment_time")
  DateTime? commentTime;

  CommentVO({
    this.id,
    this.commentOwnerId,
    this.postId,
    this.commentContent,
    this.commentTime,
  });

  factory CommentVO.fromJson(Map<String,dynamic> json) => _$CommentVOFromJson(json);
  Map<String,dynamic> toJson() => _$CommentVOToJson(this);
}
