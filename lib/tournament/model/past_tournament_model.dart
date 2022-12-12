// class LankTModel {
//   final int lank_1;
//
//   final int lank_2;
//
//   final int lank_3;
//
//   final int lank_4;
//
//   LankTModel({
//     required this.lank_1,
//     required this.lank_2,
//     required this.lank_3,
//     required this.lank_4,
//   });
//
//   factory LankTModel.fromJson({
//     required Map<String, dynamic> json,
//   }) {
//     return LankTModel(
//         lank_1: json['lank_1'],
//         lank_2: json['lank_2'],
//         lank_3: json['lank_3'],
//         lank_4: json['lank_4']
//     );
//   }
// }

class PastTModel {
  final String photo;
  final String member_id;

  final int lank_1;

  final int lank_2;

  final int lank_3;

  final int lank_4;

  PastTModel({
    required this.photo,
    required this.member_id,
    required this.lank_1,
    required this.lank_2,
    required this.lank_3,
    required this.lank_4,
  });

  factory PastTModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return PastTModel(
      photo: json['photo'],
      member_id: json['member_id'],
        lank_1: json['lank_1'],
        lank_2: json['lank_2'],
        lank_3: json['lank_3'],
        lank_4: json['lank_4']
    );
  }
}