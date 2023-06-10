import 'package:howlook/feed/model/reply_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reply_page_model.g.dart';

@JsonSerializable()
class ReplyPageModel {
  final List<ReplyModel> replies;
  final int totalPages;
  final int nowPage;

  ReplyPageModel({
    required this.replies,
    required this.totalPages,
    required this.nowPage,
  });

  ReplyPageModel copyWith({
    List<ReplyModel>? replies,
    int? totalPages,
    int? nowPage,
  }) {
    return ReplyPageModel(
      replies: replies ?? this.replies,
      totalPages: totalPages ?? this.totalPages,
      nowPage: nowPage ?? this.nowPage,
    );
  }

  factory ReplyPageModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyPageModelToJson(this);
}