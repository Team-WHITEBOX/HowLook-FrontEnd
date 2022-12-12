class SelectTournaModel {
  final int t_post_id;

  final int feed_id;

  final String photo;

  final int score;

  SelectTournaModel({
    required this.t_post_id,
    required this.feed_id,
    required this.photo,
    required this.score,
  });

  factory SelectTournaModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return SelectTournaModel(
        t_post_id: json['t_post_id'],
        feed_id: json['feed_id'],
        photo: json['photo'],
        score: json['score']
    );
  }

}
