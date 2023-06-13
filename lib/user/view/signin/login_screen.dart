import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/component/cust_textform_filed.dart';
import '../../../common/const/colors.dart';
import '../../../common/const/data.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/secure_storage/secure_storage.dart';
import '../../../common/view/root_tab.dart';
import '../../../manager/view/manager_root_screen.dart';
import '../../model/sign_in_model.dart';
import '../../provider/sign_in_provider.dart';
import '../../repository/sign_in_repository.dart';
import '../signup/main_signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  bool _isValid() {
    final memberId = ref.watch(memberIdProvider);
    final memberPassword = ref.watch(memberPasswordProvider);
    return (memberId.isNotEmpty & memberPassword.isNotEmpty) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final memberId = ref.watch(memberIdProvider);
    final memberPassword = ref.watch(memberPasswordProvider);

    return DefaultLayout(
      title: '',
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 상단 텍스트
                  const Title(),
                  const SizedBox(height: 16.0),
                  const SubTitle(),
                  const SizedBox(height: 80.0),
                  const LoginText(),
                  const SizedBox(height: 30.0),
                  CustomTextFormField(
                    label: "아이디",
                    onChanged: (value) {
                      ref
                          .read(memberIdProvider.notifier)
                          .update((state) => value);
                    },
                    onSaved: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return '아이디를 입력하세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: "비밀번호",
                    onChanged: (value) {
                      ref
                          .read(memberPasswordProvider.notifier)
                          .update((state) => value);
                    },
                    onSaved: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return '비밀번호를 입력하세요';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        try {
                          SignInModel signInModel = SignInModel(
                            memberId: memberId,
                            memberPassword: memberPassword,
                          );

                          final resp = await ref
                              .read(signInRepositoryProvider)
                              .generateToken(signInModel.toJson());

                          final refreshToken = resp.data.refreshToken;
                          final accessToken = resp.data.accessToken;

                          final storage = ref.read(secureStorageProvider);

                          await storage.write(
                              key: REFRESH_TOKEN_KEY, value: refreshToken);
                          await storage.write(
                              key: ACCESS_TOKEN_KEY, value: accessToken);
                          await storage.write(
                              key: USERMID_KEY, value: memberId);

                          ref
                              .read(memberIdProvider.notifier)
                              .update((state) => "");
                          ref
                              .read(memberPasswordProvider.notifier)
                              .update((state) => "");

                          if (!mounted) return;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => RootTab(),
                            ),
                            (route) => false,
                          );
                        } catch (e) {
                          showOkAlertDialog(
                            context: context,
                            barrierDismissible: false,
                            title: "로그인 실패",
                            message: "아이디와 비밀번호를 다시 확인해주세요",
                          );
                        }
                      }
                      // ID:비밀번호 형태
                      // final rawString = '$username:$password';

                      // ** 중요한 코드 ** -> convert to base 64
                      // Flutter에서 ID, PW를 Base64 인코딩을 정의하는 코드
                      // Codec<String, String> stringToBase64 = utf8.fuse(base64);
                      // Flutter에서 ID, PW를 실제로 Base64로 인코딩하는 코드
                      // String token = stringToBase64.encode(rawString);

                      /*
                        final resp = await dio.post(
                          'http://$ip/auth/login',
                          options: Options(headers: {
                            'authorization': 'Basic $token',
                          }),
                        );
                         */
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isValid() ? Colors.black : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(100, 50),
                    ),
                    child: const Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () async {
                      ref.read(memberIdProvider.notifier).update((state) => "");
                      ref
                          .read(memberPasswordProvider.notifier)
                          .update((state) => "");
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const MainSignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Hello👋",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "만나서 반가워요 :)\n로그인을 해서 다양한 패션을 만나보세요!",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w100,
        fontFamily: 'NotoSans',
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "HowLook",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    );
  }
}
