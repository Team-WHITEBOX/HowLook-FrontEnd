import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/review/feedback/view/feedback_result_screen.dart';

import '../model/feedback_model.dart';
import '../model/normal_feedback_model.dart';
import '../provider/normal_feedback_provider.dart';
import '../model/normal_feedback_model_data.dart';
import '../component/normal_feedback_card.dart';
import '../repository/normal_feedback_repository.dart';

class NormalFeedback extends ConsumerWidget {
  NormalFeedback({Key? key}) : super(key: key);

  late int count = 0;
  late Future<FeedbackModel> _NormalFeedbackFuture;

  Future<void> _fetchMainReviewModel(WidgetRef ref) async {
    final repository = ref.read(NormalFeedbackRepositoryProvider);
    _NormalFeedbackFuture = repository.getMemberId();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _fetchMainReviewModel(ref);

    return DefaultLayout(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<FeedbackModel>(
                  future: _NormalFeedbackFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print("error1");
                      return Text('Error: ${snapshot.error}');
                    } else {

                      final feedBackModel = ref
                          .read(NormalFeedbackProvider.notifier)
                          .getFeedbackData();

                      return FutureBuilder<NormalFeedbackModel>(
                        future: feedBackModel,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError || snapshot.data?.data == [] ||
                                  snapshot.data == null )
                          { return Center(
                              child: Container(
                                height: 400,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        '평가글이 없습니다.',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '당신의 스타일을 평가받아보세요!',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            final feedbackDataModel = snapshot.data!.data ?? [];
                            return SizedBox(
                              height: 400,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Swiper(
                                  autoplay: false,
                                  scale: 0.9,
                                  viewportFraction: 0.8,
                                  itemCount: feedbackDataModel.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return NormalFeedbackCard.fromModel(
                                      model: feedbackDataModel[index],
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
