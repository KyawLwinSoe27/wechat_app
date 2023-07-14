import 'package:json_annotation/json_annotation.dart';
part 'message_vo.g.dart';
@JsonSerializable()
class MessageVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "file")
  String? file;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "sender_name")
  String? senderName;

  @JsonKey(name: "sender_profile_picture")
  String? senderProfilePicture;

  @JsonKey(name: "timestamp")
  String? timestamp;

  @JsonKey(name: "sender_id")
  String? senderId;

  MessageVO(
      {
        required this.id,
        required this.file,
      required this.message,
      required this.senderName,
      required this.senderProfilePicture,
      required this.timestamp,
      required this.senderId});

  factory MessageVO.fromJson(Map<String,dynamic> json) => _$MessageVOFromJson(json);
  Map<String,dynamic> toJson() => _$MessageVOToJson(this);
}
