import 'package:json_annotation/json_annotation.dart';

part 'category_pagination_params.g.dart';

@JsonSerializable()
class CategoryPaginationParams {
  final int? page;
  final int? size; // 추가된 매개변수
  final bool? hashtagDTOAmekaji;
  final bool? hashtagDTOCasual;
  final bool? hashtagDTOGuitar;
  final bool? hashtagDTOMinimal;
  final bool? hashtagDTOSporty;
  final bool? hashtagDTOStreet;
  final int? heightHigh;
  final int? heightLow;
  final int? weightHigh;
  final int? weightLow;
  final String? gender;

  const CategoryPaginationParams({
    this.page,
    this.size,
    this.hashtagDTOAmekaji,
    this.hashtagDTOCasual,
    this.hashtagDTOGuitar,
    this.hashtagDTOMinimal,
    this.hashtagDTOSporty,
    this.hashtagDTOStreet,
    this.gender,
    this.heightHigh,
    this.heightLow,
    this.weightHigh,
    this.weightLow,
  });

  CategoryPaginationParams copyWith({
    int? page,
    int? size, // 추가된 매개변수
    bool? hashtagDTOAmekaji,
    bool? hashtagDTOCasual,
    bool? hashtagDTOGuitar,
    bool? hashtagDTOMinimal,
    bool? hashtagDTOSporty,
    bool? hashtagDTOStreet,
    int? heightHigh,
    int? heightLow,
    int? weightHigh,
    int? weightLow,
    String? gender,
  }) {
    return CategoryPaginationParams(
      page: page ?? this.page,
      size: size ?? this.size, // 추가된 매개변수
      hashtagDTOAmekaji: hashtagDTOAmekaji ?? this.hashtagDTOAmekaji,
      hashtagDTOCasual: hashtagDTOCasual ?? this.hashtagDTOCasual,
      hashtagDTOGuitar: hashtagDTOGuitar ?? this.hashtagDTOGuitar,
      hashtagDTOMinimal: hashtagDTOMinimal ?? this.hashtagDTOMinimal,
      hashtagDTOSporty: hashtagDTOSporty ?? this.hashtagDTOSporty,
      hashtagDTOStreet: hashtagDTOStreet ?? this.hashtagDTOStreet,
      heightHigh: heightHigh ?? this.heightHigh,
      heightLow: heightLow ?? this.heightLow,
      weightHigh: weightHigh ?? this.weightHigh,
      weightLow: weightLow ?? this.weightLow,
      gender: gender ?? this.gender,
    );
  }

  factory CategoryPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$CategoryPaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryPaginationParamsToJson(this);
}
