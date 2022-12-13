import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/tournament/select/view/rect_clipper.dart';
import 'package:howlook/tournament/select/view/BeforeAfterScreen.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:howlook/tournament/select/model/tourna_select_model.dart';

class TournamentIngCard extends StatefulWidget {
  final int t_post_id;

  final int feed_id;

  final String photo;

  final int score;

  TournamentIngCard({
    Key? key,
    required this.t_post_id,
    required this.feed_id,
    required this.photo,
    required this.score,
  }): super(key: key);

  factory TournamentIngCard.fromModel({
    required SelectTournaModel model,
  }) {
    return TournamentIngCard(
        t_post_id: model.t_post_id,
        feed_id: model.feed_id,
        photo: model.photo,
        score: model.score,
    );
  }

  @override
  State<TournamentIngCard> createState() => _TournamentIngCardState();
}

class _TournamentIngCardState extends State<TournamentIngCard> {
  final List<String> images = <String>[
    'asset/img/Profile/HL1.JPG',
    'asset/img/Profile/HL2.JPG',
    'asset/img/Profile/HL3.JPG',
    'asset/img/Profile/HL4.JPG'
  ];

  String result = "";
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                const SizedBox(height: 15.0),
                BeforeAfter(
                  beforeImage: tournamentImage(images[0]),
                  afterImage: tournamentImage(images[1]),
                ),
                const SizedBox(height: 15.0),
                Text('Choose your preferred photo.',style: TextStyle(fontSize: 20),),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectButton<int>(
                      value: 1,
                      groupValue: _value,
                      leading: 'A',
                      title: Text('Left'),
                      onChanged: (value) => setState(() => _value = value!),
                    ),
                    selectButton<int>(
                      value: 2,
                      groupValue: _value,
                      leading: 'B',
                      title: Text('Right'),
                      onChanged: (value) => setState(() => _value = value!),
                    ),
                  ],
                )
              ],
            );
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
