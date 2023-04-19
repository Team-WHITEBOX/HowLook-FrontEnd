import 'dart:io';

import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';

class TempScreen extends StatelessWidget {
  final String path;
  const TempScreen({required this.path, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'hi2',
      child: Image.file(File(path)),
    );
  }
}
