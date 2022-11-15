import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';

class MainSignupScreen extends StatelessWidget {
  const MainSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [

              ],
            ),
          ),
        )
    );
  }
}
