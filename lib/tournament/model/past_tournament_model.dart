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
  final List<PostDTOS> postDTOS;

  PastTModel({
    required this.postDTOS,
  });

  factory PastTModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return PastTModel(
      postDTOS: json['memberFeeds']
          .map<PostDTOS>(
            (x) => PostDTOS(
              feed_id: x['feed_id'],
              photo: x['photo'],
              member_id: x['member_id'],
            ),
          )
          .toList(),
    );
  }
}

class PostDTOS {
  // 포스트 아이디
  final int feed_id;
  // 이미지 경로
  final String photo;

  final String member_id;

  PostDTOS({
    required this.feed_id,
    required this.photo,
    required this.member_id,
  });

  factory PostDTOS.fromJson({
    required Map<String, dynamic> json,
  }) {
    return PostDTOS(
      feed_id: json['feed_id'],
      photo: json['photo'],
      member_id: json['member_id'],
    );
  }
}
