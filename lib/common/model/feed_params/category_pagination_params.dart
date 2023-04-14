import 'package:json_annotation/json_annotation.dart';

part 'category_pagination_params.g.dart';

@JsonSerializable()
class CategoryPaginationParams {
  final int? page;
  final bool? amekaji;
  final bool? casual;
  final bool? guitar;
  final bool? minimal;
  final bool? sporty;
  final bool? street;
  final double? heightHigh;
  final double? heightLow;
  final double? weightHigh;
  final double? weightLow;
  final String? gender;
  // final String? after;

  const CategoryPaginationParams({
    this.page,
    this.amekaji,
    this.casual,
    this.guitar,
    this.minimal,
    this.sporty,
    this.street,
    this.gender,
    this.heightHigh,
    this.heightLow,
    this.weightHigh,
    this.weightLow,
  });

  CategoryPaginationParams copyWith({
    int? page,
    bool? amekaji,
    bool? casual,
    bool? guitar,
    bool? minimal,
    bool? sporty,
    bool? street,
    double? heightHigh,
    double? heightLow,
    double? weightHigh,
    double? weightLow,
    String? gender,
  }) {
    return CategoryPaginationParams(
      page: page ?? this.page,
      amekaji: amekaji ?? this.amekaji,
      casual: casual ?? this.casual,
      guitar: guitar ?? this.guitar,
      minimal: minimal ?? this.minimal,
      sporty: sporty ?? this.sporty,
      street: street ?? this.street,
      heightHigh: heightHigh ?? this.heightHigh,
      heightLow: heightLow ?? this.heightLow,
      weightHigh: weightHigh ?? this.weightHigh,
      weightLow: weightLow ?? this.heightLow,
      gender: gender ?? this.gender,
    );
  }

  factory CategoryPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$CategoryPaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryPaginationParamsToJson(this);
}
