import 'package:flutter/material.dart';

class MainFeedDetailComment extends StatelessWidget {
  const MainFeedDetailComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        height: 500,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )
        ),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
