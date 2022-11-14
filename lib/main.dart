import 'package:flutter/material.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/user/view/login_screen.dart';
import 'package:howlook/user/view/splash_screen.dart';

void main() {
  runApp(
    _App(),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: Splash_Screen(),
    );
  }
}
