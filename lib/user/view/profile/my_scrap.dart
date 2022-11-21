import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/signin/main_login_screen.dart';
import 'package:howlook/user/view/signup/second_signup_screen.dart';
import 'package:flutter/cupertino.dart';

class MyScrap extends StatefulWidget {
  const MyScrap({Key? key}) : super(key: key);

  @override
  State<MyScrap> createState() => _MyScrap();
}

class _MyScrap extends State<MyScrap> {

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'ScrapLook',
        actions: <Widget>[
          CupertinoButton(
            onPressed: () => _showActionSheet(context),
            child: Icon(Icons.more_vert_sharp),
          ),
        ],
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 100,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.grey,
              );
            }
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('스크랩 선택하기'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('선택'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('cancle'),
          ),
        ],
      ),
    );
  }

}
