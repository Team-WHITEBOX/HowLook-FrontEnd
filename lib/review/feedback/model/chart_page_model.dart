class ChartModel {
  // 남자 차트
  final List<dynamic> maleCounts;
  // 여자 차트
  final List<dynamic> femaleCounts;

  ChartModel({
    required this.maleCounts,
    required this.femaleCounts,
  });

  factory ChartModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ChartModel(
      maleCounts: json['maleCounts'],
      femaleCounts: json['femaleCounts'],
    );
  }
}