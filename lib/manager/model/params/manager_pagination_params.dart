import 'package:json_annotation/json_annotation.dart';

part 'manager_pagination_params.g.dart';

@JsonSerializable()
class ManagerPaginationParams {
  final int? page;

  const ManagerPaginationParams({
    this.page,
  });

  ManagerPaginationParams copyWith({
    int? page,
  }) {
    return ManagerPaginationParams(
      page: page ?? this.page,
    );
  }

  factory ManagerPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$ManagerPaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerPaginationParamsToJson(this);
}
