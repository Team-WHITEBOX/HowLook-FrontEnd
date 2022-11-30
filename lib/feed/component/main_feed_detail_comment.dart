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
            )),
        child: Column(
          children: [
            Stack(children: [
              Container(
                width: double.infinity,
                height: 56.0,
                child: Center(
                    child: Text(
                  "댓글",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
              ),
              Positioned(
                  right: 15,
                  top: 7,
                  child: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.black,
                      ), // Your desired icon
                      onPressed: () {
                        Navigator.of(context).pop();
                      }))
            ]),
          ],
        ),
      ),
    );
  }
}
