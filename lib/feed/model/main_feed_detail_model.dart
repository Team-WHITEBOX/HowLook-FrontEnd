import 'package:howlook/feed/model/main_feed_model.dart';

class MainFeedDetailModel extends MainFeedModel {
  // 좋아요
  final int likeCount;
  // 댓글
  final int commentCount;
  // 내용
  final String content;
  // 등록 날짜
  final List<dynamic> regDate;

  MainFeedDetailModel({
    required super.userPostInfo,
    required super.npostId,
    required super.photoDTOs,
    required super.photoCnt,
    required this.likeCount,
    required this.commentCount,
    required this.content,
    required this.regDate,
  });

  factory MainFeedDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MainFeedDetailModel(
      userPostInfo: UserInfoModel.fromJson(
          json: Map<String, dynamic>.from(json['userPostInfo'])),
      npostId: json['npostId'],
      photoDTOs: json['photoDTOs']
          .map<PhotoDTOs>(
            (x) => PhotoDTOs(
              path: x['path'],
              photoId: x['photoId'],
            ),
          )
          .toList(),
      photoCnt: json['photoCnt'],
      likeCount: json['npostId'], // 임시
      commentCount: json['npostId'], // 임시
      content: json['content'],
      regDate: json['regDate'],
    );
  }
}
