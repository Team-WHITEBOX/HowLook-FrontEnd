// 데이터 전달에 사용할 클래스
import 'package:flutter/material.dart';

class CategoryModel {
  final bool isManChecked;
  final bool isWomanChecked;
  // 스타일
  final bool isMinimalChecked;
  final bool isCasualChecked;
  final bool isStreetChecked;
  final bool isAmericanCasualChecked;
  final bool isSportyChecked;
  final bool isEtcChecked;
  // 키
  final int minHeight;
  final int maxHeight;
  // 몸무게
  final int minWeight;
  final int maxWeight;

  CategoryModel({
    required this.isManChecked,
    required this.isWomanChecked,
    required this.isMinimalChecked,
    required this.isCasualChecked,
    required this.isStreetChecked,
    required this.isAmericanCasualChecked,
    required this.isSportyChecked,
    required this.isEtcChecked,
    required this.minWeight,
    required this.maxWeight,
    required this.minHeight,
    required this.maxHeight,
  });

  CategoryModel copyWith({
    bool? isManChecked,
    bool? isWomanChecked,
    // 스타일
    bool? isMinimalChecked,
    bool? isCasualChecked,
    bool? isStreetChecked,
    bool? isAmericanCasualChecked,
    bool? isSportyChecked,
    bool? isEtcChecked,
    // 키
    int? minHeight,
    int? maxHeight,
    // 몸무게
    int? minWeight,
    int? maxWeight,

  }) {
    return CategoryModel(
      isManChecked: isManChecked ?? this.isManChecked,
      isWomanChecked: isWomanChecked ?? this.isWomanChecked,
      isMinimalChecked: isMinimalChecked ?? this.isMinimalChecked,
      isCasualChecked: isCasualChecked ?? this.isCasualChecked,
      isStreetChecked: isStreetChecked ?? this.isStreetChecked,
      isAmericanCasualChecked:
          isAmericanCasualChecked ?? this.isAmericanCasualChecked,
      isSportyChecked: isSportyChecked ?? this.isSportyChecked,
      isEtcChecked: isEtcChecked ?? this.isEtcChecked,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      minWeight: minWeight ?? this.minWeight,
      maxWeight: maxWeight ?? this.maxWeight,
    );
  }
}
