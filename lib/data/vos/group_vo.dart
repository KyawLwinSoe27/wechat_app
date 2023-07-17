import 'package:json_annotation/json_annotation.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
part 'group_vo.g.dart';
@JsonSerializable()
class GroupVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "members")
  List<String>? members;

  @JsonKey(name: "messages")
  List<MessageVO>? messages;

  GroupVO({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.members,
    required this.messages,
  });

  factory GroupVO.fromJson(Map<String,dynamic> json) => _$GroupVOFromJson(json);
  Map<String,dynamic> toJson() => _$GroupVOToJson(this);
}
