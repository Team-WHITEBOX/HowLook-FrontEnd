import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/user/view/splash_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  await initializeDefault();
  KakaoSdk.init(nativeAppKey: 'fee362483928c6b3bbbb934a9996d8cb');
  runApp(
    const ProviderScope(
      child: _App(),
    ),
  );
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  print('Initialized default app $app');
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
      home: const Splash_Screen(),
    );
  }
}