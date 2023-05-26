
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/const/data.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KakaoLoginScreen extends StatelessWidget {
  //const KakaoLoginScreen({Key? key}) : super(key: key);
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        // 여기부터 주목
        initialUrl: "https://kauth.kakao.com/oauth/authorize?client_id=eaea17f771b2bbca9bb72a90b36e5244&redirect_uri=http://3.34.164.14:8080/account/oauth/kakao&response_type=code",
        onWebViewCreated: (WebViewController webviewController) {
          _controller = webviewController;
        },
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: Set.from([
          JavascriptChannel(
            name: 'JavaScriptChannel',
            onMessageReceived: (JavascriptMessage message) {
              if ((message.message).contains('accessToken')) {
                print(message.message);
                Navigator.pop(context, message.message);
              }
            },
          )
        ]),
      ),
    );
  }
}

// body: Container(
//   child: Center(
//     child: ElevatedButton(
//       onPressed: () {
//         KakaoLogin();
//       },
//       child: Text("KAKAO"),
//     ),
//   ),
// ),

// void KakaoLogin() async {
//   if (await isKakaoTalkInstalled()) {
//     try {
//       OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
//       print('df${token.accessToken}');
//       // await AuthCodeClient.instance.authorize(
//       //   redirectUri: 'http:/$API_SERVICE_URI/login/oauth2/code/kakao',
//       //   final dio = new Dio();
//       //   final resp = await dio.get(
//       //     'http://3.34.164.14:8080/oauth2/authorization/kakao',
//       //   );
//       // }
//     } catch (error) {
//       print('카카오계정으로 로그인 실패 $error');
//     }
//   }
// }
