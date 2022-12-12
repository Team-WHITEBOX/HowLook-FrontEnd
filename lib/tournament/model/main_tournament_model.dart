class MainTournaModel {
  final int t_post_id;

  final int feed_id;

  final String photo;

  final int score;

  MainTournaModel({
    required this.t_post_id,
    required this.feed_id,
    required this.photo,
    required this.score,
  });

  factory MainTournaModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return MainTournaModel(
      t_post_id: json['t_post_id'],
      feed_id: json['feed_id'],
      photo: json['photo'],
      score: json['score']
    );
  }

}
