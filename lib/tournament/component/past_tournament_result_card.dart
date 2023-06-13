import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:howlook/tournament/model/main_tournament/main_tournament_model.dart';

class PastTournamentResultCard extends StatelessWidget {
  final int tournamentPostId;
  final List<int> date;
  final int postId;
  final String photo;
  final String memberId;
  final int score;
  final String tournamentType;

  const PastTournamentResultCard({
    required this.tournamentPostId,
    required this.date,
    required this.postId,
    required this.photo,
    required this.memberId,
    required this.score,
    required this.tournamentType,
    super.key,
  });

  factory PastTournamentResultCard.fromModel({
    required MainTournamentModel model,
  }) {
    return PastTournamentResultCard(
      tournamentPostId: model.tournamentPostId,
      date: model.date,
      postId: model.postId,
      photo: model.photo,
      memberId: model.memberId,
      score: model.score,
      tournamentType: model.tournamentType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffececec),
                    width: 1,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, 7),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 7),
                                    )
                                  ],
                                ),
                                child: ExtendedImage.network(
                                  photo,
                                  width: 90,
                                  height: 90,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "참가자: $memberId",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'NanumSquareNeo',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "점수: $score",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'NanumSquareNeo',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              (() {
                if (score == 10) {
                  return ExtendedImage.asset(
                    'asset/img/rank/1.png',
                    width: 45,
                    height: 45,
                  );
                } else if (score == 7) {
                  return ExtendedImage.asset(
                    'asset/img/rank/2.png',
                    width: 45,
                    height: 45,
                  );
                } else if (score == 5) {
                  return ExtendedImage.asset(
                    'asset/img/rank/3.png',
                    width: 45,
                    height: 45,
                  );
                } else {
                  return Container();
                }
              })(),
            ],
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
