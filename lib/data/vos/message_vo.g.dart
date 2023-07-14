// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      id: json['id'] as String?,
      file: json['file'] as String?,
      message: json['message'] as String?,
      senderName: json['sender_name'] as String?,
      senderProfilePicture: json['sender_profile_picture'] as String?,
      timestamp: json['timestamp'] as String?,
      senderId: json['sender_id'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'message': instance.message,
      'sender_name': instance.senderName,
      'sender_profile_picture': instance.senderProfilePicture,
      'timestamp': instance.timestamp,
      'sender_id': instance.senderId,
    };
