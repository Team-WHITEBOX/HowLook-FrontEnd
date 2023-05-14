// 데이터 전달에 사용할 클래스
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String gender;
  // 스타일
  final bool hashtagDTOMinimal;
  final bool hashtagDTOCasual;
  final bool hashtagDTOStreet;
  final bool hashtagDTOAmekaji;
  final bool hashtagDTOSporty;
  final bool hashtagDTOGuitar;
  // 키
  final int heightLow;
  final int heightHigh;
  // 몸무게
  final int weightLow;
  final int weightHigh;


  CategoryModel({
    required this.gender,
    required this.hashtagDTOMinimal,
    required this.hashtagDTOCasual,
    required this.hashtagDTOStreet,
    required this.hashtagDTOAmekaji,
    required this.hashtagDTOSporty,
    required this.hashtagDTOGuitar,
    required this.weightLow,
    required this.weightHigh,
    required this.heightLow,
    required this.heightHigh,
  });

  CategoryModel copyWith({
    String? gender,
    // 스타일
    bool? hashtagDTOMinimal,
    bool? hashtagDTOCasual,
    bool? hashtagDTOStreet,
    bool? hashtagDTOAmekaji,
    bool? hashtagDTOSporty,
    bool? hashtagDTOGuitar,
    // 키
    int? heightLow,
    int? heightHigh,
    // 몸무게
    int? weightLow,
    int? weightHigh,

  }) {
    return CategoryModel(
      gender: gender ?? this.gender,
      hashtagDTOMinimal: hashtagDTOMinimal ?? this.hashtagDTOMinimal,
      hashtagDTOCasual: hashtagDTOCasual ?? this.hashtagDTOCasual,
      hashtagDTOStreet: hashtagDTOStreet ?? this.hashtagDTOStreet,
      hashtagDTOAmekaji:
      hashtagDTOAmekaji ?? this.hashtagDTOAmekaji,
      hashtagDTOSporty: hashtagDTOSporty ?? this.hashtagDTOSporty,
      hashtagDTOGuitar: hashtagDTOGuitar ?? this.hashtagDTOGuitar,
      heightLow: heightLow ?? this.heightLow,
      heightHigh: heightHigh ?? this.heightHigh,
      weightLow: weightLow ?? this.weightLow,
      weightHigh: weightHigh ?? this.weightHigh,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
