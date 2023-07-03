import 'package:json_annotation/json_annotation.dart';
part 'get_otp_vo.g.dart';
@JsonSerializable()
class GetOTPVO {
  @JsonKey(name: "otp_code")
  int? otpCode;

  GetOTPVO(
      this.otpCode
      );

  factory GetOTPVO.fromJson(Map<String,dynamic> json) => _$GetOTPVOFromJson(json);
  Map<String,dynamic> toJson() => _$GetOTPVOToJson(this);
}