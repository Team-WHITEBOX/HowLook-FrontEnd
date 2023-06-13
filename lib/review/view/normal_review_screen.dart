import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/review/component/nomal_review_card.dart';
import '../model/creator_review_model.dart';
import '../model/normal_review_model.dart';
import '../model/normal_review_model_data.dart';
import '../repository/normal_review_repository.dart';
import 'package:dio/dio.dart' hide Headers;

//일반 평가하기
class NormalReview extends ConsumerWidget {
  NormalReview({Key? key}) : super(key: key);

  late Future<ReviewModel> _reviewModelFuture;

  Future<void> _fetchReviewModel(WidgetRef ref) async {
    final repository = ref.read(NormalReviewRepositoryProvider);
    _reviewModelFuture = repository.reviewData();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _fetchReviewModel(ref); // _fetchReviewModel 호출

    return DefaultLayout(
      title: 'Normal Review',
      child: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder<ReviewModel>(
            future: _reviewModelFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final pItem = snapshot.data!.data;
                return NormalReviewCard.fromModel(model: pItem);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
