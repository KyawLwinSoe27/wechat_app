// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentVO _$CommentVOFromJson(Map<String, dynamic> json) => CommentVO(
      id: json['comment_id'] as String?,
      commentOwnerId: json['comment_owner_id'] as String?,
      postId: json['post_id'] as String?,
      commentContent: json['comment_content'] as String?,
      commentTime: json['comment_time'] == null
          ? null
          : DateTime.parse(json['comment_time'] as String),
    );

Map<String, dynamic> _$CommentVOToJson(CommentVO instance) => <String, dynamic>{
      'comment_id': instance.id,
      'comment_owner_id': instance.commentOwnerId,
      'post_id': instance.postId,
      'comment_content': instance.commentContent,
      'comment_time': instance.commentTime?.toIso8601String(),
    };
