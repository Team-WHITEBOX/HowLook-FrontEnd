import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';

class MyScrap extends StatefulWidget {
  const MyScrap({Key? key}) : super(key: key);

  @override
  State<MyScrap> createState() => _MyScrap();
}

class _MyScrap extends State<MyScrap> {
  final List<String> images = <String>['asset/img/Profile/HL1.JPG', 'asset/img/Profile/HL2.JPG', 'asset/img/Profile/HL3.JPG', 'asset/img/Profile/HL4.JPG'];
  //static const int _count = images.length;
  //final List<bool> _checks = List.generate(_count, (_) => false);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Scrap Look',
      actions: <Widget>[
        CupertinoButton(
          onPressed: () => _showActionSheet(context),
          child: Icon(Icons.more_vert_sharp),
        ),
      ],
      child: GridView.builder(
          //physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Image.asset(images[index], fit: BoxFit.cover,),
              );
              //return Stack(
                //children: [
                  //Container(child: Image.asset(images[index], fit: BoxFit.cover,)),
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: Checkbox(
                  //     value: _checks[index],
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         _checks[index] = newValue;
                  //       },);
                  //     },
                  //   ),
                  // ),
                //],
              //);
            }
        ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoActionSheet(
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