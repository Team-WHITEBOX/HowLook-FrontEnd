import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged,
    this.obscureText = false,
    this.autofocus = false,
    this.hintText,
    this.errorText,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 2.0,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText, // 비밀번호 가리는거
      autofocus: autofocus, // 오토 포커싱 기능
      onChanged: onChanged,

      // Input을 데코하는 함수
      decoration: InputDecoration(
        // 양 쪽으로 땡겨서 커서 포인터 이쁘게 만드는 것,,
        contentPadding: EdgeInsets.all(20),
        // placeholder 같은 것
        hintText: hintText,
        errorText: errorText,

        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        fillColor: INPUT_BG_COLOR,

        // false - 배경색 없음
        // true  - 배경색 있음
        filled: true,

        // 모든 Input 상태의 기본 스타일
        border: baseBorder,
        enabledBorder: baseBorder,
        // 선택된 Input 상태의 기본 스타일
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          )
        ),
      ),
    );
  }
}
