import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/user/view/splash_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: 'eaea17f771b2bbca9bb72a90b36e5244');
  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: CandyGlobalVariable.naviagatorState,
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: Splash_Screen(),
    );
  }
}

class CandyGlobalVariable {
  static final GlobalKey<NavigatorState> naviagatorState =
  GlobalKey<NavigatorState>();
}