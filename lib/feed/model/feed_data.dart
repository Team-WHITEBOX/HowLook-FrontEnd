import 'package:howlook/feed/model/feed_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_data.g.dart';

@JsonSerializable()
class FeedData {
  final FeedModel data;

  FeedData({
    required this.data,
  });

  FeedData copyWith({
    FeedModel? data,
  }) {
    return FeedData(
      data: data ?? this.data,
    );
  }

  factory FeedData.fromJson(Map<String, dynamic> json) =>
      _$FeedDataFromJson(json);

  Map<String, dynamic> toJson() => _$FeedDataToJson(this);
}
