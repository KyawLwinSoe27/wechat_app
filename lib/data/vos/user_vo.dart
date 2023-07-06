import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  @JsonKey(name: "date_of_birth")
  DateTime? dateOfBirth;

  @JsonKey(name: "gender")
  int? gender;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "profile_picture")
  String? profilePicture;


  UserVO({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.password,
    this.profilePicture,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);
  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
