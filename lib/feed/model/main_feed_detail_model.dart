import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:howlook/feed/model/photo_dto.dart';
import 'package:howlook/feed/model/userinfomodel.dart';

class MainFeedDetailModel extends MainFeedModel {
  // 좋아요 수
  final int likeCount;
  // 본인의 좋아요 체크 여부
  final bool like_chk;
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
    required this.like_chk,
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
      likeCount: json['likeCount'], // 임시
      like_chk: json['like_chk'],
      commentCount: json['commentCount'], // 임시
      content: json['content'],
      regDate: json['regDate'],
    );
  }
}
