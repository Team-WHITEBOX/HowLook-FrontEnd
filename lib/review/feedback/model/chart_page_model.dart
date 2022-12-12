class ChartModel {
  // 남자 차트
  final List<dynamic> maleCounts;
  // 여자 차트
  final List<dynamic> femaleCounts;

  final double replyCount;

  ChartModel({
    required this.maleCounts,
    required this.femaleCounts,
    required this.replyCount,
  });

  factory ChartModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ChartModel(
      maleCounts: json['maleCounts'],
      femaleCounts: json['femaleCounts'],
      replyCount: json['replyCount'].toDouble(),
    );
  }
}