import 'package:howlook/feed/model/comment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_page_model.g.dart';

@JsonSerializable()
class CommentPageModel {
  final List<CommentModel> replies;
  final int totalPages;
  final int nowPage;

  CommentPageModel({
    required this.replies,
    required this.totalPages,
    required this.nowPage,
  });

  CommentPageModel copyWith({
    List<CommentModel>? replies,
    int? totalPages,
    int? nowPage,
  }) {
    return CommentPageModel(
      replies: replies ?? this.replies,
      totalPages: totalPages ?? this.totalPages,
      nowPage: nowPage ?? this.nowPage,
    );
  }

  factory CommentPageModel.fromJson(Map<String, dynamic> json) =>
      _$CommentPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentPageModelToJson(this);
}