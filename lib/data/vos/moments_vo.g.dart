// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moments_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentsVO _$MomentsVOFromJson(Map<String, dynamic> json) => MomentsVO(
      id: json['post_id'] as String?,
      postOwnerId: json['post_owner_id'] as String?,
      postContent: json['content'] as String?,
      likeCount: (json['like_count'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      media:
          (json['media'] as List<dynamic>?)?.map((e) => e as String).toList(),
      postTime: json['post_time'] == null
          ? null
          : DateTime.parse(json['post_time'] as String),
      postOwnerName: json['post_owner_name'] as String?,
      postOwnerPhoto: json['post_owner_photo'] as String?,
    );

Map<String, dynamic> _$MomentsVOToJson(MomentsVO instance) => <String, dynamic>{
      'post_id': instance.id,
      'post_owner_id': instance.postOwnerId,
      'content': instance.postContent,
      'like_count': instance.likeCount,
      'media': instance.media,
      'post_time': instance.postTime?.toIso8601String(),
      'post_owner_name': instance.postOwnerName,
      'post_owner_photo': instance.postOwnerPhoto,
    };
