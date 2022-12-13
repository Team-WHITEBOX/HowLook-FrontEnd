import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:intl/intl.dart';
import 'package:howlook/tournament/model/past_tournament_model.dart';

class pastTournamentCard extends StatefulWidget {
   final int index;
  // // 포스트 아이디
  // final int feed_id;
  // // 이미지 경로
  // final String photo;
  //
  // final String member_id;
  //
  // pastTournamentCard({
  //   required this.index,
  //   required this.feed_id,
  //   required this.photo,
  //   required this.member_id,
  //   // required this.index
  //   Key? key,
  // }) : super(key : key);
  //
  // factory pastTournamentCard.fromModel({
  //   required PastTModel model,
  //   required int indexValue
  // }) {
  //   return pastTournamentCard(
  //     feed_id: model.feed_id,
  //     photo: model.photo,
  //     member_id: model.member_id,
  //     index: indexValue,
  //   );
  // }

  final List<PostDTOS> postDTOS;

  const pastTournamentCard({
    required this.index,
    required this.postDTOS,
    Key? key})
      : super(key: key);

  factory pastTournamentCard.fromModel({
    required PastTModel model,
    required int indexValue
  }) {
    return pastTournamentCard(
      index: indexValue,
      postDTOS: model.postDTOS,
    );
  }

  // final String photo;
  // final String member_id;
  //
  // final int lank_1;
  //
  // final int lank_2;
  //
  // final int lank_3;
  //
  // final int lank_4;
  //
  // pastTournamentCard({
  //   Key? key,
  //   required this.photo,
  //   required this.member_id,
  //   required this.lank_1,
  //   required this.lank_2,
  //   required this.lank_3,
  //   required this.lank_4,
  // }): super(key: key);
  //
  // factory pastTournamentCard.fromModel({
  //   required PastTModel model,
  // }) {
  //   return pastTournamentCard(
  //     photo: model.photo,
  //     member_id: model.member_id,
  //     lank_1: model.lank_1,
  //     lank_2: model.lank_2,
  //     lank_3: model.lank_3,
  //     lank_4: model.lank_4,
  //   );
  // }

  @override
  State<pastTournamentCard> createState() => _pastTournamentCardState();
}

// class _pastTournamentCardState extends State<pastTournamentCard> {
//   ScrollController scrollController = ScrollController();
//
//
//   List<String> topRanks = ["🥇", "🥈", "🥉"];
//   String tournamentday = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultLayout(
//         title: '지난 랭킹 순위',
//         child: Scaffold(
//             body: NestedScrollView(
//               headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//                 return <Widget>[
//                   SliverAppBar(
//                     collapsedHeight: MediaQuery.of(context).size.width * 0.3,
//                     pinned: true,
//                     expandedHeight: MediaQuery.of(context).size.width * 0.2,
//                     flexibleSpace: FlexibleSpaceBar(
//                       title: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Center(
//                             child: TextButton(
//                               onPressed: () {
//                                 DatePicker.showDatePicker(
//                                   context,
//                                   showTitleActions: true,
//                                   minTime: DateTime(1900, 1, 1),
//                                   maxTime: DateTime(2022, 12, 31),
//                                   currentTime: DateTime.now(),
//                                   locale: LocaleType.ko,
//                                   onConfirm: (date) {
//                                     tournamentday = DateFormat('yyyy-MM-dd').format(date);
//                                     Text( //랜킹날짜 안내글 어떻게하지...
//                                         '${tournamentday} 랭킹 결과',
//                                         style: TextStyle(
//                                           color: Colors.grey,)
//                                     );
//                                   },
//                                 );
//                               },
//                               child: Text(
//                                 "보고싶은 순위의 날짜를 선택하세요",
//                                 style: TextStyle(
//                                   color: PRIMARY_COLOR,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 10.0),
//                           Center(
//                             child: Container(
//                                 child: Text(
//                                   '총 n명이 참여했습니다.',
//                                   style: TextStyle(color: Colors.grey, fontSize: 15),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       background: const SizedBox(
//                         child: ColoredBox(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ];
//               },
//               body: LankingView(), //ScoreScreen(),
//             )));
//   }
//
//   Widget LankingView() {
//     return CustomScrollView(
//       shrinkWrap: true,
//       slivers: <Widget>[
//         SliverPadding(
//             padding: EdgeInsets.all(20.0),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 childCount: images.length,
//                     (context, index) {
//                   return listCard(index);
//                 },
//               ),
//             ))
//       ],
//     );
//   }
//
//
//   Widget listCard(int index) {
//     return Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             begin: Alignment.bottomRight,
//             end: Alignment.topLeft,
//             colors: [
//               Color(0xFFD07AFF),
//               Color(0xFFa6ceff),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(40),
//         ),
//         margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//                 padding: EdgeInsets.all(3),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                       begin: Alignment.bottomRight,
//                       end: Alignment.topLeft,
//                       colors: [
//                         Color(0xFFa6ceff),
//                         Color(0xFFD07AFF),
//                       ]),
//                   borderRadius: BorderRadius.circular(500),
//                 ),
//                 child: CircleAvatar(
//                   radius: MediaQuery.of(context).size.width / 14,
//                   backgroundImage: AssetImage(images[index]),
//                 )),
//
//             const SizedBox(width: 10.0),
//             Text(
//               '${index+1} 위.', // 원하는 형태로 조합
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               ' ${name[index]}', // 원하는 형태로 조합
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Text(
//                 index < 3 ? topRanks[index] + ' ' : ' ',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 27.0,
//                   fontWeight: FontWeight.w300,
//                   letterSpacing: 1.0,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         )
//     );
//   }
//
// }

class Index{
  final int indexV;

  Index(this.indexV);
}
class _pastTournamentCardState extends State<pastTournamentCard> {
  ScrollController scrollController = ScrollController();
  List<String> topRanks = ["🥇", "🥈", "🥉"];
  //
  // int index=0;


  final indexes = List<Index>.generate(
    4,
        (i) => Index(i),
  );

  @override
  Widget build(BuildContext context) {
    return listCard(widget.index);
    // //return listCard(widget.index);
    // return Container(
    //     child:listCard(index)
    // );
  }

  // Widget LankingView() {
  //   return CustomScrollView(
  //     shrinkWrap: true,
  //     slivers: <Widget>[
  //       SliverPadding(
  //           padding: EdgeInsets.all(20.0),
  //           sliver: SliverList(
  //             delegate: SliverChildBuilderDelegate(
  //               childCount: widget.postDTOS.length,
  //                   (context, index) {
  //                 return listCard(index);
  //               },
  //             ),
  //           ))
  //     ],
  //   );
  // }


  // class PostDTOS {
  // // 포스트 아이디
  // final int feed_id;
  // // 이미지 경로
  // final String photo;
  //
  // final String member_id;
  //

  Widget listCard(int index) {
    // int index = widget.postDTOS.length;
    return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xFFD07AFF),
              Color(0xFFa6ceff),
            ],
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xFFa6ceff),
                        Color(0xFFD07AFF),
                      ]),
                  borderRadius: BorderRadius.circular(500),
                ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 14,
                  backgroundImage: NetworkImage('https://howlook-s3-bucket.s3.ap-northeast-2.amazonaws.com/${widget.postDTOS[index].photo}'),

                )),

            const SizedBox(width: 10.0),
            Text(
              '${index+1} 위.', // 원하는 형태로 조합
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              ' ${widget.postDTOS[index].member_id}', // 원하는 형태로 조합
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                index < 3 ? topRanks[index] + ' ' : ' ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
    );
  }

}
