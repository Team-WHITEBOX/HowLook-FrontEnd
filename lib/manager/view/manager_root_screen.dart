import 'package:flutter/material.dart';

import '../../common/layout/default_layout.dart';
import 'manager_home_screen.dart';


class ManagerRootScreen extends StatelessWidget {
  const ManagerRootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'HowLook Management',
      child: ManagerHomeScreen(),
    );
  }
}
