import 'package:flutter/material.dart';

class CustIconButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? icon;

  const CustIconButton({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: 10,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(icon),
      ),
    );
  }
}
