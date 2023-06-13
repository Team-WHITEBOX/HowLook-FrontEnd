import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/review/component/nomal_review_card.dart';
import '../component/creator_review_card.dart';
import '../model/creator_review_model.dart';
import '../model/normal_review_model.dart';
import '../model/normal_review_model_data.dart';
import '../repository/normal_review_repository.dart';
import 'package:dio/dio.dart' hide Headers;

//일반 평가하기
class CreaterReview extends ConsumerStatefulWidget {
  CreaterReview({Key? key}) : super(key: key);

  @override
  ConsumerState<CreaterReview> createState() => _CreaterReviewState();
}

class _CreaterReviewState extends ConsumerState<CreaterReview> {
  late Future<CreatorReviewModel> _reviewCreatorModelFuture;

  Future<void> _fetchReviewModel(WidgetRef ref) async {
    final repository = ref.read(NormalReviewRepositoryProvider);
    try {
      _reviewCreatorModelFuture = repository.reviewCreatorData();
    } catch (err) {
      print("Hello");
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchReviewModel(ref); // _fetchReviewModel 호출

    return DefaultLayout(
      title: 'Creator Review',
      child: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder<CreatorReviewModel>(
            future: _reviewCreatorModelFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final pItem = snapshot.data!.data;
                return CreatorReviewCard.fromModel(model: pItem);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
