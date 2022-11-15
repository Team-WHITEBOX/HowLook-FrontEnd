import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';

class MainFeedScreen extends StatelessWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return Container(
      child: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
            },
            child: Text('버튼'),
          )
        ],
      )),
    );
  }
}
