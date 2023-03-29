import 'package:howlook/common/utils/data_utils.dart';
import 'package:howlook/feed/model/feed_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_model.g.dart';

@JsonSerializable()
class PageModel {
  final List<FeedModel> content;
  final int totalPages;
  final int number;

  PageModel({
    required this.content,
    required this.totalPages,
    required this.number,
  });

  PageModel copyWith({
    List<FeedModel>? content,
    int? totalPages,
    int? number,
  }) {
    return PageModel(
      content: content ?? this.content,
      totalPages: totalPages ?? this.totalPages,
      number: number ?? this.number,
    );
  }

  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageModelToJson(this);
}
