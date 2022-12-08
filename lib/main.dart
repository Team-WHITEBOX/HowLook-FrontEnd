import 'package:flutter/material.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/user/view/splash_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() {
  KakaoSdk.init(
    nativeAppKey: 'fee362483928c6b3bbbb934a9996d8cb'
  );
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
