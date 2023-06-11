import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/component/cust_textform_filed.dart';
import '../../../common/layout/default_layout.dart';
import '../../../user/provider/sign_up_provider.dart';
import '../../../user/repository/sign_up_repository.dart';
import '../../../user/view/signup/first_signup_screen.dart';
import '../../provider/profile_edit_provider.dart';

class ProfileChangeScreen extends ConsumerStatefulWidget {
  const ProfileChangeScreen({super.key});

  @override
  ConsumerState<ProfileChangeScreen> createState() => _ProfileChangeScreen();
}

class _ProfileChangeScreen extends ConsumerState<ProfileChangeScreen> {
  final formKey = GlobalKey<FormState>();

  bool _isValid() {
    final userData = ref.watch(profileEditProvider);
    final nickCheck = ref.watch(editNicknameProvider);

    bool status = nickCheck &&
        userData.memberNickName.isNotEmpty &&
        userData.memberPhone.isNotEmpty &&
        (userData.memberHeight >= 100 && userData.memberHeight <= 250) &&
        (userData.memberWeight >= 20 && userData.memberWeight <= 150);

    return status;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(profileEditProvider);
    final nickCheck = ref.watch(editNicknameProvider);

    Future<void> submit() async {
      final result =
          await ref.read(profileEditProvider.notifier).updateProfileData();

      if (result) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("회원 정보 수정이 완료되었어요 :)"),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("죄송합니다. 회원 정보가 수정되지 않았어요 :("),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    return DefaultLayout(
      title: '',
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageTitle(title: "회원 정보 수정 ✏️"),
                  const SizedBox(height: 16.0),
                  PageSubTitle(subTitle: "새로운 정보를 기입해주세요 :)"),
                  const SizedBox(height: 40.0),
                  PageLabelText("별명"),
                  const SizedBox(height: 5),
                  Stack(
                    children: [
                      CustomTextFormField(
                        initialValue: userData.memberNickName,
                        hintText: "별명을 입력해주세요",
                        onSaved: (value) {},
                        onChanged: (value) {
                          ref
                              .read(profileEditProvider.notifier)
                              .addMemberNickName(memberNickName: value);
                          ref
                              .read(editNicknameProvider.notifier)
                              .update((state) => false);
                        },
                        validator: (value) {
                          if (value.length < 1) {
                            return "별명은 1자보다 짧을 수 없어요 :(";
                          } else if (value.length > 9) {
                            return "별명은 10자보다 길 수 없어요 :(";
                          }
                          return null;
                          // 닉네임 중복 조회
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      Positioned(
                        right: 1,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (userData.memberNickName.length > 1) {
                              final code = await ref
                                  .read(signUpRepositoryProvider)
                                  .nickCheck(nickName: userData.memberNickName);
                              if (code.data) {
                                ref
                                    .read(editNicknameProvider.notifier)
                                    .update((state) => true);
                                if (!mounted) return;
                                showOkAlertDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    title: "닉네임 사용 가능",
                                    message: "해당 닉네임은 사용 가능합니다.");
                              } else {
                                if (!mounted) return;
                                showOkAlertDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    title: "닉네임 사용 불가능",
                                    message: "해당 닉네임은 사용이 불가능합니다.");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (userData.memberNickName.length > 2 && nickCheck)
                                ? Colors.black
                                : Colors.grey,
                          ),
                          child: const Text(
                            "중복 확인",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  PageLabelText("휴대폰 번호"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    initialValue: userData.memberPhone,
                    hintText: "휴대폰 번호를 입력해주세요",
                    helperText: "(예시) 01012341234, - 를 제외한 숫자를 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(profileEditProvider.notifier)
                          .addMemberPhone(memberPhone: value);
                    },
                    validator: (value) {
                      if (isValidPhoneFormat(value.toString())) {
                        return null;
                      } else {
                        return "잘못된 휴대폰 번호 형식입니다 :(";
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24.0),
                  PageLabelText("키"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    initialValue: userData.memberHeight.toString(),
                    hintText: "키를 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(profileEditProvider.notifier)
                          .addMemberHeight(memberHeight: int.parse(value));
                    },
                    helperText: "100 ~ 250cm 범위 내로, 숫자만 입력해주세요",
                    validator: (value) {
                      if (isValidHeightFormat(value.toString()) &&
                          (int.parse(value) >= 100 &&
                              int.parse(value) <= 250)) {
                        return null;
                      } else {
                        return "잘못된 키 형식입니다 :(";
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24.0),
                  PageLabelText("몸무게"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    initialValue: userData.memberWeight.toString(),
                    hintText: "몸무게를 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(profileEditProvider.notifier)
                          .addMemberWeight(memberWeight: int.parse(value));
                    },
                    helperText: "20 ~ 150kg 범위 내로, 숫자만 입력해주세요",
                    validator: (value) {
                      if (isValidWeightFormat(value.toString()) &&
                          (int.parse(value) >= 20 && int.parse(value) <= 150)) {
                        return null;
                      } else {
                        return "잘못된 몸무게 형식입니다 :(";
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_isValid()) {
                        if (!nickCheck) {
                          if (!mounted) return;
                          showOkAlertDialog(
                              context: context,
                              barrierDismissible: false,
                              title: "닉네임 중복 확인",
                              message: "닉네임 중복 확인을 먼저 해주세요");
                        } else if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          submit();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isValid() ? Colors.black : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(100, 50),
                    ),
                    child: const Text(
                      "가입하기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 80.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidPhoneFormat(String memberPhone) {
    return RegExp(r'^[0-9]{11}$').hasMatch(memberPhone);
  }

  bool isValidHeightFormat(String memberHeight) {
    return RegExp(r'^[0-9]{3}$').hasMatch(memberHeight);
  }

  bool isValidWeightFormat(String memberWeight) {
    return RegExp(r'^[0-9]{2,3}$').hasMatch(memberWeight);
  }
}
