// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupVO _$GroupVOFromJson(Map<String, dynamic> json) => GroupVO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      members:
          (json['members'] as List<dynamic>?)?.map((e) => e as String).toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => MessageVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupVOToJson(GroupVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_picture': instance.profilePicture,
      'members': instance.members,
      'messages': instance.messages,
    };
