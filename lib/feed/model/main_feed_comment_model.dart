class MainFeedCommentModel {
  // 댓글 아이디
  final int replyId;
  // 댓글 부모 아이디
  final int parentId;
  // 댓글 좋아요 수
  final int likeCount;
  // 댓글 작성자 닉네임
  final String nickName;
  // 댓글 작성자 프로필 사진
  final String profilePhoto;
  // 댓글 내가 체크 여부
  final bool like_chk;
  // 댓글 내용
  final String contents;
  // 포스트 아이디
  final int npostId;

  MainFeedCommentModel({
    required this.replyId,
    required this.parentId,
    required this.likeCount,
    required this.nickName,
    required this.profilePhoto,
    required this.like_chk,
    required this.contents,
    required this.npostId,
  });

  factory MainFeedCommentModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MainFeedCommentModel(
      parentId: json['parentId'],
      profilePhoto: json['profilePhoto'],
      contents: json['contents'],
      npostId: json['npostId'],
      replyId: json['replyId'],
      nickName: json['nickName'],
      likeCount: json['likeCount'],
      like_chk: json['like_chk'],
    );
  }
}