// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:howlook/common/const/colors.dart';
//
// class CustomTextFormField extends StatelessWidget {
//   final String? hintText;
//   final String? errorText;
//   final bool obscureText;
//   final bool autofocus;
//   final TextInputType? keyboardType;
//   final ValueChanged<String>? onChanged;
//   final FormFieldValidator? validator;
//   final TextInputAction? textInputAction;
//   final IconButton? icon;
//
//   const CustomTextFormField({
//     required this.onChanged,
//     this.icon,
//     this.textInputAction,
//     this.obscureText = false,
//     this.autofocus = false,
//     this.keyboardType,
//     this.hintText,
//     this.errorText,
//     this.validator,
//     Key? key
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final baseBorder = UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: INPUT_BORDER_COLOR,
//         width: 2.0,
//       ),
//     );
//
//     return TextFormField(
//       cursorColor: PRIMARY_COLOR,
//       obscureText: obscureText, // 비밀번호 가리는거
//       autofocus: autofocus, // 오토 포커싱 기능
//       onChanged: onChanged,
//       keyboardType: keyboardType,
//       textInputAction: textInputAction,
//       validator: validator,
//
//       // Input을 데코하는 함수
//       decoration: InputDecoration(
//         // 양 쪽으로 땡겨서 커서 포인터 이쁘게 만드는 것,,
//         contentPadding: EdgeInsets.only(
//           left: 0,
//           right: 20,
//           bottom: 10,
//           top: 20,
//         ),
//         // placeholder 같은 것
//         hintText: hintText,
//         errorText: errorText,
//
//         hintStyle: TextStyle(
//           color: BODY_TEXT_COLOR,
//           fontSize: 14.0,
//         ),
//         fillColor: INPUT_BG_COLOR,
//
//         // false - 배경색 없음
//         // true  - 배경색 있음
//         filled: false,
//
//         // 모든 Input 상태의 기본 스타일
//         border: baseBorder,
//         enabledBorder: baseBorder,
//         // 선택된 Input 상태의 기본 스타일
//         focusedBorder: baseBorder.copyWith(
//           borderSide: baseBorder.borderSide.copyWith(
//             color: PRIMARY_COLOR,
//           )
//         ),
//
//         suffixIcon: icon,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  int? maxLines;
  final String? label;
  final String? hintText;
  final String? errorText;
  bool? isBorder;
  final bool obscureText;
  final bool autofocus;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;
  final IconButton? icon;
  final FormFieldSetter? onSaved;

  CustomTextFormField(
      {this.maxLines = 1,
      this.label,
      this.onChanged,
      this.isBorder = true,
      this.icon,
      this.textInputAction,
      this.obscureText = false,
      this.autofocus = false,
      this.keyboardType,
      this.hintText,
      this.errorText,
      this.validator,
      this.onSaved,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(onSaved != null);
    assert(validator != null);

    final baseBorder = UnderlineInputBorder(
        borderSide: isBorder!
            ? const BorderSide(
                color: INPUT_BORDER_COLOR,
                width: 1.5,
              )
            : BorderSide.none);

    return Column(
      children: [
        Row(
          children: [
            if (label != null)
              Text(
                label!,
                style: const TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.w700),
              ),
          ],
        ),
        // const SizedBox(height: 5),
        TextFormField(
          maxLines: maxLines,
          cursorColor: Colors.black,
          obscureText: obscureText, // 비밀번호 가리는거
          autofocus: autofocus, // 오토 포커싱 기능
          onChanged: onChanged,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onSaved: onSaved,

          // Input을 데코하는 함수
          decoration: InputDecoration(
            // 양 쪽으로 땡겨서 커서 포인터 이쁘게 만드는 것,,
            contentPadding: const EdgeInsets.only(
              left: 2,
              right: 20,
              bottom: 10,
              top: 10,
            ),
            // placeholder 같은 것
            hintText: hintText,
            errorText: errorText,

            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
            fillColor: Colors.black,

            // false - 배경색 없음
            // true  - 배경색 있음
            filled: false,

            // 모든 Input 상태의 기본 스타일
            border: baseBorder,
            enabledBorder: baseBorder,
            // 선택된 Input 상태의 기본 스타일
            focusedBorder: baseBorder.copyWith(
                borderSide:
                    baseBorder.borderSide.copyWith(color: Colors.black)),
            suffixIcon: icon,
          ),
        ),
      ],
    );
  }
}
