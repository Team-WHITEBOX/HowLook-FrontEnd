import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:howlook/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    required this.onChanged,
    this.textInputAction,
    this.obscureText = false,
    this.autofocus = false,
    this.keyboardType,
    this.hintText,
    this.errorText,
    this.validator,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = UnderlineInputBorder(
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
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,

      // Input을 데코하는 함수
      decoration: InputDecoration(
        // 양 쪽으로 땡겨서 커서 포인터 이쁘게 만드는 것,,
        contentPadding: EdgeInsets.only(
          left: 0,
          right: 20,
          bottom: 10,
          top: 20,
        ),
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
        filled: false,

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
