import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';

class CreaterReview extends StatefulWidget {
  const CreaterReview({Key? key}) : super(key: key);

  @override
  State<CreaterReview> createState() => _CreaterReviewState();
}

class _CreaterReviewState extends State<CreaterReview> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'creater Review',
      child: SingleChildScrollView(
          child: SafeArea(
              child: Container(
                child: Center(
                  child: Text('사용하실 수 없는 기능입니다.'),
                )
              )
          )
      ),
    );
  }
}

