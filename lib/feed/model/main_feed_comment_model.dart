class MainFeedCommentModel {
  // 댓글 부모 아이디
  final int parentId;
  // 댓글 작성자 프로필 사진
  final String profilePhoto;
  // 댓글 내용
  final String contents;
  // 포스트 아이디
  final int npostId;
  // 댓글 아이디
  final int replyId;
  // 댓글 작성자 닉네임
  final String nickname;

  MainFeedCommentModel({
    required this.parentId,
    required this.profilePhoto,
    required this.contents,
    required this.npostId,
    required this.replyId,
    required this.nickname,
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
      nickname: json['nickname'],
    );
  }
}