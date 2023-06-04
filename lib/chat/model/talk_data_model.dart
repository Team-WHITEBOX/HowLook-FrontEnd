import 'package:howlook/chat/model/new_talk_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talk_data_model.g.dart';

@JsonSerializable()
class TalkDataModel {
  final List<NewTalkModel> data;

  TalkDataModel({
    required this.data,
  });

  TalkDataModel copyWith({
    List<NewTalkModel>? data,
  }) {
    return TalkDataModel(
      data: data ?? this.data,

    );
  }

  factory TalkDataModel.fromJson(Map<String, dynamic> json) =>
      _$TalkDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$TalkDataModelToJson(this);
}
