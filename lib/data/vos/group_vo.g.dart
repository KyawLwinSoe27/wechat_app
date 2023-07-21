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
      messages: _parseMessages(json['messages']),
    );

List<MessageVO> _parseMessages(dynamic messagesData) {
  List<MessageVO> messages = [];
  if (messagesData is List) {
    messages = messagesData
        .map((e) => MessageVO.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  } else if (messagesData is Map) {
    messages = [MessageVO.fromJson(Map<String, dynamic>.from(messagesData))];
  }
  return messages;
}

Map<String, dynamic> _$GroupVOToJson(GroupVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_picture': instance.profilePicture,
      'members': instance.members,
      'messages': instance.messages,
    };
