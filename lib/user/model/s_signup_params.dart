// import 'package:json_annotation/json_annotation.dart';
//
// @JsonSerializable()
// class sPostParams {
//
//   final String? name;
//   final String? nickName;
//   final String? phone;
//   final int? height;
//   final int? weight;
//   final String? birthDay;
//
//   const sPostParams({
//     this.name,
//     this.nickName,
//     this.phone,
//     this.height,
//     this.weight,
//     this.birthDay,
//   });
//
//   sPostParams copyWith({
//     String? name,
//     String? nickName,
//     String? phone,
//     int? height,
//     int? weight,
//     String? birthDay,
//   }) {
//     return sPostParams(
//       name: name ?? this.name,
//       nickName: nickName ?? this.nickName,
//       phone: phone ?? this.phone,
//       height: height ?? this.height,
//       weight: weight ?? this.weight,
//       birthDay: birthDay ?? this.birthDay,
//     );
//   }
//
//   factory sPostParams.fromJson(Map<String, dynamic> json) =>
//       _$SingupParams_SFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SingupParams_SToJson(this);
//
// }
