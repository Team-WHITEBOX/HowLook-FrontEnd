import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/tournament/select/model/tourna_select_model.dart';
import 'package:howlook/tournament/select/component/tourna_select_card.dart';

class TournamentIng extends StatefulWidget {
  const TournamentIng({Key? key}) : super(key: key);

  @override
  State<TournamentIng> createState() => _TournamentIngState();
}

class _TournamentIngState extends State<TournamentIng> {
  final List<String> images = <String>[
    'asset/img/Profile/HL1.JPG',
    'asset/img/Profile/HL2.JPG',
    'asset/img/Profile/HL3.JPG',
    'asset/img/Profile/HL4.JPG'
  ];

  String result = "";
  int _value = 0;

  String postid = '';
  String tournamentday = '';
  //
  // Future<List> paginatePickTourna(String tournamentday) async {
  //   print(tournamentday);
  //   final dio = Dio();
  //   final storage = ref.read(secureStorageProvider);
  //   final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
  //   final resp = await dio.get(
  //     // MainFeed 관련 api IP주소 추가하기
  //     'http://$API_SERVICE_URI/tournament/post/$tournamentday',
  //     options: Options(
  //       headers: {
  //         'authorization': 'Bearer $accessToken',
  //       },
  //     ),
  //   );
  //   print(resp.data['data']);
  //   return resp.data['data'];
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '오늘의 토너먼트',
        child: SingleChildScrollView(
          child: SafeArea(
            // child: FutureBuilder<List>(
            //     future: paginatePickTourna(tournamentday),
            //     builder: (_, AsyncSnapshot<List> snapshot) {
            //       // 에러처리
            //       if (!snapshot.hasData) {
            //         print('error');
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //       final item = snapshot.data![0];
            //       final pItem = SelectTournaModel.fromJson(json: item);
            //       return TournamentIngCard.fromModel(model: pItem);
            //     }),
            child: Text('df'),
          ),
        ));
  }

  Widget tournamentImage(String path) {
    return AspectRatio(
        aspectRatio: 0.8,
        child: Container(
          //child: Image.network(images[index], fit: BoxFit.cover,),
          child: Image.asset(
            '${path}',
            fit: BoxFit.cover,
          ),
          // -> 네트워크로 수정하기
        )
        // -> PhotoCnt로 수정
        );
  }
}

// 선택 버튼 코드
class selectButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const selectButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            SizedBox(width: 12),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? PRIMARY_COLOR : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? PRIMARY_COLOR : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
