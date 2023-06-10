import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/user/view/signin/intro_screen.dart';
import 'package:howlook/user/view/signup/first_signup_screen.dart';
import 'package:intl/intl.dart';
import 'package:howlook/user/model/sign_up/sign_up_model.dart';
import 'package:howlook/user/provider/sign_up_provider.dart';
import 'package:howlook/user/repository/sign_up_repository.dart';

class SecondSignupScreen extends ConsumerStatefulWidget {
  final bool? isSocial;

  const SecondSignupScreen({
    required this.isSocial,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SecondSignupScreen> createState() => _SecondSignupScreenState();
}

class _SecondSignupScreenState extends ConsumerState<SecondSignupScreen> {
  final formKey = GlobalKey<FormState>();
  final List gender = ["남자", "여자"];

  String? gen;

  bool _isValid() {
    final newMember = ref.watch(signUpProvider);
    bool status = newMember.nickName!.isNotEmpty &&
        newMember.phone!.isNotEmpty &&
        (newMember.height! >= 100 && newMember.height! <= 250) &&
        (newMember.weight! >= 20 && newMember.weight! <= 150) &&
        newMember.birthDay!.isNotEmpty;

    if (widget.isSocial!) {
      // 소셜이라면 status 그대로 반환
      return status;
    } else {
      // 소셜 아니라면 gender 값이 비어있는지 확인하고 반환
      return (status && newMember.gender!.isNotEmpty);
    }
  }

  @override
  Widget build(BuildContext context) {
    final newMember = ref.watch(signUpProvider);
    final nickCheck = ref.watch(idNicknameProvider);
    final bool isSocial = widget.isSocial!;

    Future<void> submit() async {
      final result = isSocial
          ? await ref.read(signUpProvider.notifier).socialEdit()
          : await ref.read(signUpProvider.notifier).postJoin();

      if (result) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("환영해요 ${newMember.name}님! 가입이 완료되었어요 :)"),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => IntroScreen(),
          ),
          (route) => false,
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("죄송합니다. 가입이 이루어지지 않았어요 다시 시도해주세요 :("),
            duration: Duration(seconds: 3),
          ),
        );
      }

      // // 소셜 회원가입이 아닐 때 바로 가입 진행
      // if (newMember.memberId != null)
      //   repos.postData(signupModel: newMember);
      // // 소셜 로그인일 때,
      // else {
      //   postData();
      //   ref.watch(signUpProvider.notifier).outputSignupModel();
      // }
    }

    return DefaultLayout(
      title: '',
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
                  const PageTitle(),
                  const SizedBox(height: 16.0),
                  const PageSubTitle(),
                  const SizedBox(height: 40.0),
                  const PageLabelText(labelText: "이름"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "이름을 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(signUpProvider.notifier)
                          .addMemberName(memberName: value);
                    },
                    validator: (value) {
                      if (value!.length < 2) {
                        return "이름은 2자보다 짧을 수 없어요 :(";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 24.0),
                  const PageLabelText(labelText: "별명"),
                  const SizedBox(height: 5),
                  Stack(
                    children: [
                      CustomTextFormField(
                        hintText: "별명을 입력해주세요",
                        onSaved: (value) {},
                        onChanged: (value) {
                          ref
                              .read(signUpProvider.notifier)
                              .addMemberNickName(memberNickName: value);
                          ref
                              .read(idNicknameProvider.notifier)
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
                            if (newMember.nickName!.length > 2) {
                              final code = await ref
                                  .read(signUpRepositoryProvider)
                                  .nickCheck(nickName: newMember.nickName!);
                              if (code.data) {
                                ref
                                    .read(idNicknameProvider.notifier)
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
                            backgroundColor: newMember.nickName!.length > 2
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
                  const PageLabelText(labelText: "휴대폰 번호"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "휴대폰 번호를 입력해주세요",
                    helperText: "(예시) 01012341234, - 를 제외한 숫자를 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(signUpProvider.notifier)
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
                  isSocial ? Container() : genderBySocial(),
                  const PageLabelText(labelText: "키"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "키를 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(signUpProvider.notifier)
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
                  const PageLabelText(labelText: "몸무게"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    hintText: "몸무게를 입력해주세요",
                    onSaved: (value) {},
                    onChanged: (value) {
                      ref
                          .read(signUpProvider.notifier)
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
                  const PageLabelText(labelText: "생일"),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: DateTime(2023, 12, 31),
                        currentTime: DateTime.now(),
                        locale: LocaleType.ko,
                        onConfirm: (date) {
                          ref.read(signUpProvider.notifier).addMemberBirthday(
                                memberBirthday:
                                    DateFormat("yyyy-MM-dd").format(date),
                              );
                        },
                      );
                    },
                    child: Text(
                      newMember.birthDay == ""
                          ? "당신의 생일을 알려주세요 :)"
                          : newMember.birthDay!.substring(0, 10),
                      style: const TextStyle(
                        fontSize: 18,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
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

  Widget genderBySocial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PageLabelText(labelText: "성별"),
        const SizedBox(height: 5),
        Column(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '선택하기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: gender
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: gen,
                onChanged: (value) {
                  setState(() {
                    gen = value;
                  });

                  ref.read(signUpProvider.notifier).addMemberGender(
                        memberGender: gen == "남자" ? "M" : "F",
                      );
                },
                buttonStyleData: const ButtonStyleData(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.expand_more, color: Colors.grey, size: 24),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  elevation: 2,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 45,
                  padding: EdgeInsets.only(left: 12, right: 2),
                ),
              ),
            ),
            Container(color: INPUT_BORDER_COLOR, height: 2),
          ],
        ),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
