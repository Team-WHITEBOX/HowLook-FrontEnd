import 'package:howlook/feed/model/main_feed_model.dart';

class MainFeedDetailModel extends MainFeedModel{
  // 좋아요
  final int likeCount;
  // 댓글
  final int commentCount;
  // 내용
  final String content;

  MainFeedDetailModel({
    required super.userPostInfo,
    required super.npostId,
    required super.photoPaths,
    required super.photoCnt,
    required this.likeCount,
    required this.commentCount,
    required this.content,
});

  factory MainFeedDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MainFeedDetailModel(
      userPostInfo: UserInfoModel.fromJson(json: Map<String, dynamic>.from(json['userPostInfo'])),
      npostId: json['npostId'],
      photoPaths: List<String>.from(json['photoPaths']),
      photoCnt: json['photoCnt'],
      likeCount: json['npostId'], // 임시
      commentCount: json['npostId'], // 임시
      content: json['content'],
    );
  }
}